# BH1750

Toit driver for the Rohm Semi BH1750 Ambient Light Sensor.

## Usage
### Continuous measurement
```
import gpio
import i2c
import bh1750

main:
  bus := i2c.Bus
    --sda=gpio.Pin 21
    --scl=gpio.Pin 22

  device := bus.device bh1750.I2C_ADDRESS
  driver := bh1750.Driver device bh1750.BH1750_CONTINUOUS_HIGH_RES_MODE

  while true:
    print "$driver.lux lux"
    sleep --ms=1000
```
### One measurement then power down
```
import gpio
import i2c
import bh1750

main:
  bus := i2c.Bus
    --sda=gpio.Pin 21
    --scl=gpio.Pin 22

  device := bus.device bh1750.I2C_ADDRESS
  driver := bh1750.Driver device bh1750.BH1750_ONE_TIME_HIGH_RES_MODE

  print "$driver.lux lux"
```

## Limitations
The library doesn't support changing modes once initialized. 