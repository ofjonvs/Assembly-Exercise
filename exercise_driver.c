#include <stdio.h>
#include <avr/sleep.h>
#include <avr/interrupt.h>
#include "serial.h"

extern uint16_t Five(void);
extern uint8_t Max(uint8_t a, uint8_t b);
extern uint16_t Strlen(const char *s);

#define RUN(x) printf(#x " is %d\n", x)

int main() {
  init_serial_stdio();
  RUN(Five());

  RUN(Max(1,2));
  RUN(Max(2,1));
  RUN(Max(200,250));

  RUN(Strlen("twine"));
  RUN(Strlen("yarn"));
  RUN(Strlen("this string is meant to test whether a string longer than 255 bytes gets the right length computed by your Strlen assembly implementation because you might otherwise not ensure that the length counter is a 16-bit word, even though the simulator doesn't expect such a long string either. (292)"));

  cli();
  sleep_cpu();
    
}
