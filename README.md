# ADC-interface
- Current project includes DE-10 nano, a HDSP-521 7 segment display, and AD7910 ADC for analog digital conversion with SPI interface. 
- Clock is slowed to 2Hz, but can be changed in clock_gen up to max 50MHz
- Upon chip select, 16 bits of conversion data is transferred to serial out with 4 leading bits and a 12 bit data stream.
