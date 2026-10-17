#ifndef CMSIS_POSIX_COMPILER_H
#define CMSIS_POSIX_COMPILER_H

#define __NO_RETURN __attribute__((noreturn))
#define __STATIC_INLINE static inline
#define __WEAK __attribute__((weak))

#define __get_IPSR() 0U
#define __get_PRIMASK() 0U
#define __disable_irq() ((void)0)
#define __enable_irq() ((void)0)

#endif
