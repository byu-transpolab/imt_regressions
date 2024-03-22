#' Read and clean the CSV data
#' 
read_ett <- function(ett_data_file){
  read_csv(ett_data_file, 
           col_types = cols(.default = "d", 
                            year = "c",
                            date = "c", location = "c", type = "c", period = "c",
                            time = "t", t7t5 = "t", t7t0 = "t", t5t0 = "t")) |> 
    mutate(
      type = case_when(
        grepl("PI", type) ~ "Personal Injury",
        grepl("PD", type) ~ "Property Damage",
        grepl("Fatal", type) ~ "Fatal"
      ),
      type = as_factor(type),
      #type = fct_relevel(type, levels = c("Property Damage", "Personal Injury", "Fatal")),
      date = as_date(date, format = "%m/%d/%y")
    )
}


#' Estimate models
#' 
#' @param ett_data The data frame returned from read_ett 
#' 
estimate_rt_models <- function(ett_data){
  
  models <- list()
  
  # relationship between rt and number of imts
  models[["Base"]]  <- lm(log(rt_imt) ~ n_imt + n_uhp + lanes_bottle + type,
                          data = ett_data)
  # add year
  models[["Year"]]  <- update(models[["Base"]], formula. = .~. + year)
  
  
  models
  
  
}

#' Estimate models
#' 
#' @param ett_data The data frame returned from read_ett()
#' 
estimate_ett_models <- function(ett_data){
  
  models <- list()
  
  # relationship between ett and number of imts
  models[["Base"]]  <- lm(log(ett) ~ n_imt + n_uhp + lanes_bottle + type, data = ett_data)
  models[["Year"]]  <- update(models[["Base"]], formula. = .~. + year)
  models[["Year and RT"]]  <- update(models[["Base"]], formula. = .~. + year*log(rt_imt))
  
  
  models
  
  
}


