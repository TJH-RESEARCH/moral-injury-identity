

# In case 'output' folder is deleted

if(dir.exists(here::here('output')) == FALSE) {
  dir.create(here::here('output'))
  dir.create(here::here('output/results'))
  dir.create(here::here('output/figures'))
  dir.create(here::here('output/stats'))
  dir.create(here::here('output/tables'))
  dir.create(here::here('output/session-info'))
  
  }

