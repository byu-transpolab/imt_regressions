ETTDataFile <- read.csv("data/TIM Phase III Data for ETT analysis_T7T5.csv")

LnETTVariables <- ETTData %>% 
  select(Ln.ETT,Year,Ln.AV,Crash.Type,Number.of.IMT.Teams,Number.of.UHP.Teams,RT.for.IMT.sec,Ln.RCT.for.IMT,Ln.ICT.for.IMT,Number.of.Lanes.Closed,Time.Weighted.Number.of.Lanes.Closed,Roadway.Capacity,Ln.T7.T5,Ln.T7.T0,Time.Range,Ln.ICT.for.UHP) %>% 
  transmute(LnETT = Ln.ETT,
            Year = factor(Year, levels = c("2022","2018")),
            CrashType = factor(Crash.Type, levels = c("PI Crash","PD Crash","Fatal")),
            NumTeams = Number.of.IMT.Teams,
            NumUHP = Number.of.UHP.Teams,
            RT = RT.for.IMT.sec,
            LnRCT = Ln.RCT.for.IMT,
            LnICT = Ln.ICT.for.IMT,
            LanesClosed = Number.of.Lanes.Closed,
            TWNLC = Time.Weighted.Number.of.Lanes.Closed,
            Capacity = Roadway.Capacity,
            LnT7T5 = Ln.T7.T5,
            LnT7T0 = Ln.T7.T0,
            LnAV = Ln.AV,
            TimeRange = Time.Range,
            LnUHPICT = Ln.ICT.for.UHP)

# Replace the target list below with your own:
list(
  tar_target(ett_data_file, "data/TIM Phase III Data for ETT analysis_T7T5.csv",
             format = "file"),
  tar_target(ett_data, read_ett(ett_data_file)),
  tar_target(ett_models, estimate_ett_models(ett_data)),
  tar_target(rt_models, estimate_rt_models(ett_data)),
  tar_target(ett_data, estimate_)
)