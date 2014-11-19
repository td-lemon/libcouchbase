FIND_PROGRAM(DTRACE dtrace)
IF(DTRACE)
    ADD_DEFINITIONS(-DHAVE_DTRACE)
    SET(LCB_DTRACE_HEADER "${LCB_GENSRCDIR}/probes.h")
    SET(LCB_DTRACE_SRC "${CMAKE_SOURCE_DIR}/src/probes.d")

    # Generate probes.h
    EXECUTE_PROCESS(COMMAND ${DTRACE} -C -h -s ${LCB_DTRACE_SRC} -o ${LCB_DTRACE_HEADER})

    IF(NOT APPLE)
        SET(LCB_DTRACE_OBJECT "${LCB_GENSRCDIR}/probes.o")
        # Generate probes.o
        ADD_CUSTOM_COMMAND(OUTPUT ${LCB_DTRACE_OBJECT}
            DEPENDS ${LCB_DTRACE_SRC}
            COMMAND ${DTRACE} -C -G ${LCB_DTRACE_OPTIONS} -s ${LCB_DTRACE_SRC} -o ${LCB_DTRACE_OBJECT})
    ENDIF()
ENDIF()