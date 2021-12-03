// Copyright (C) 2021 Justin Decker. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be found
// in the LICENSE file.

import gpio
import i2c
import bh1750

main:
  bus := i2c.Bus
    --sda=gpio.Pin 21
    --scl=gpio.Pin 22

  // Alternate address accessed with I2C_ADDRESS_ALT (device := bus.device bh1750.I2C_ADDRESS)
  device := bus.device bh1750.I2C_ADDRESS

  /* Pass device and mode to driver. 
     Mode options are:
      BH1750_CONTINUOUS_HIGH_RES_MODE   : 1 lx resolution, 120 ms each continuous measurement
      BH1750_CONTINUOUS_HIGH_RES_MODE_2 : 0.5 lx resolution, 120 ms each continuous measurement
      BH1750_CONTINUOUS_LOW_RES_MODE    : 4lx resoution, 16 ms each continuous measurement
      BH1750_ONE_TIME_HIGH_RES_MODE     : 1 lx resolution, 120 ms, one measurement then shuts down
      BH1750_ONE_TIME_HIGH_RES_MODE_2   : 0.5 lx resolution, 120 ms, one measurement then shuts down
      BH1750_ONE_TIME_LOW_RES_MODE      : 4 lx resolution, 16 ms, one measurement then shuts down
  */
  driver := bh1750.Driver device bh1750.BH1750_CONTINUOUS_HIGH_RES_MODE

  while true:
    print "$driver.lux lux"
    sleep --ms=1000
