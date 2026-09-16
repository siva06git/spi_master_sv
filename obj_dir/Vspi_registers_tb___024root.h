// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vspi_registers_tb.h for the primary calling header

#ifndef VERILATED_VSPI_REGISTERS_TB___024ROOT_H_
#define VERILATED_VSPI_REGISTERS_TB___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vspi_registers_tb__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vspi_registers_tb___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ spi_registers_tb__DOT__clk;
    CData/*0:0*/ spi_registers_tb__DOT__rst_n;
    CData/*0:0*/ spi_registers_tb__DOT__msb;
    CData/*0:0*/ spi_registers_tb__DOT__cpol;
    CData/*0:0*/ spi_registers_tb__DOT__cpha;
    CData/*7:0*/ spi_registers_tb__DOT__bits;
    CData/*7:0*/ spi_registers_tb__DOT__div_value;
    CData/*0:0*/ spi_registers_tb__DOT__expected_cpol;
    CData/*0:0*/ spi_registers_tb__DOT__expected_cpha;
    CData/*0:0*/ spi_registers_tb__DOT__expected_msb;
    CData/*7:0*/ spi_registers_tb__DOT__expected_bits;
    CData/*7:0*/ spi_registers_tb__DOT__expected_div_value;
    CData/*0:0*/ spi_registers_tb__DOT__unused;
    CData/*0:0*/ __Vdlyvval__spi_registers_tb__DOT__clk__v0;
    CData/*0:0*/ __Vdlyvset__spi_registers_tb__DOT__clk__v0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__spi_registers_tb__DOT__clk__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__spi_registers_tb__DOT__rst_n__0;
    CData/*0:0*/ __VactContinue;
    SData/*12:0*/ spi_registers_tb__DOT__dut__DOT__unused;
    IData/*31:0*/ spi_registers_tb__DOT__data;
    IData/*31:0*/ spi_registers_tb__DOT__stimulus;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<CData/*0:0*/, 4> __Vm_traceActivity;
    VlDelayScheduler __VdlySched;
    VlTriggerScheduler __VtrigSched_hf5f61b83__0;
    VlTriggerVec<3> __VactTriggered;
    VlTriggerVec<3> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vspi_registers_tb__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vspi_registers_tb___024root(Vspi_registers_tb__Syms* symsp, const char* v__name);
    ~Vspi_registers_tb___024root();
    VL_UNCOPYABLE(Vspi_registers_tb___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
