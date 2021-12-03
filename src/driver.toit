// Copyright (C) 2021 Toitware ApS. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be found
// in the LICENSE file.

import binary
import serial.device as serial

I2C_ADDRESS     ::= 0x23
I2C_ADDRESS_ALT ::= 0x5C

BH1750_CONTINUOUS_HIGH_RES_MODE ::= 0x10
BH1750_CONTINUOUS_HIGH_RES_MODE_2 ::= 0x11
BH1750_CONTINUOUS_LOW_RES_MODE ::=0x13
BH1750_ONE_TIME_HIGH_RES_MODE ::=0x20
BH1750_ONE_TIME_HIGH_RES_MODE_2 ::=0x21
BH1750_ONE_TIME_LOW_RES_MODE ::= 0x23

/**
Driver for the BH1750 ambient light sensor.
*/
class Driver:
  dev_/serial.Device ::= ?
  mode_ ::=?

  constructor dev/serial.Device mode/int:
    dev_ = dev
    mode_ = mode
    dev_.write #[mode]

  /**
    Measure ambient light levels.
    Returns lux in a float
  */
  lux -> float:
    if mode_ != BH1750_CONTINUOUS_LOW_RES_MODE | BH1750_CONTINUOUS_LOW_RES_MODE:
      sleep --ms=125
    else:
      sleep --ms=20

    data := dev_.read 2
    level := data[0]
    level << 8
    level |= data[1]
    return level / 1.2