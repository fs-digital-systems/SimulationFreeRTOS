#ifndef CMSIS_POSIX_COMPILER_H
#define CMSIS_POSIX_COMPILER_H

#ifndef __NO_RETURN
#define __NO_RETURN __attribute__((noreturn))
#endif
#ifndef __STATIC_INLINE
#define __STATIC_INLINE static inline
#endif
#ifndef __WEAK
#define __WEAK __attribute__((weak))
#endif

#ifndef __get_IPSR
#define __get_IPSR() 0U
#endif
#ifndef __get_PRIMASK
#define __get_PRIMASK() 0U
#endif
#ifndef __disable_irq
#define __disable_irq() ((void)0)
#endif
#ifndef __enable_irq
#define __enable_irq() ((void)0)
#endif

#endif
