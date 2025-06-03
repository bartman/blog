+++
title = "Makefile template"
date = "2007-07-22T12:37:34-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['c', 'code', 'make']
keywords = ['c', 'code', 'make']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Someone on `#oclug` was asking about building C programs with make.  I wrote up this *simple* Makefile for him.



<!--more-->



Note that you have to set `TARGET` with your executable name, and list the .c files to compile in `SRCS`.  Also,

note that Makefile indents must be **tabs**, not spaces.



        TARGET  := <<your executable name>> 

        SRCS    := <<one ore more of your .c files>> 

        OBJS    := ${SRCS:.c=.o} 

        DEPS    := ${SRCS:.c=.dep} 

        XDEPS   := $(wildcard ${DEPS}) 

         

        CCFLAGS = -std=gnu99 -O2 -Wall -Werror -ggdb 

        LDFLAGS = 

        LIBS    = 

         

        .PHONY: all clean distclean 

        all:: ${TARGET} 

         

        ifneq (${XDEPS},) 

        include ${XDEPS} 

        endif 

         

        ${TARGET}: ${OBJS} 

            ${CC} ${LDFLAGS} -o $@ $^ ${LIBS} 

         

        ${OBJS}: %.o: %.c %.dep 

            ${CC} ${CCFLAGS} -o $@ -c $< 

         

        ${DEPS}: %.dep: %.c Makefile 

            ${CC} ${CCFLAGS} -MM $< > $@ 

         

        clean:: 

           -rm -f *~ *.o ${TARGET} 

         

        distclean:: clean


