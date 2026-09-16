// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vspi_registers_tb.h for the primary calling header

#include "Vspi_registers_tb__pch.h"
#include "Vspi_registers_tb__Syms.h"
#include "Vspi_registers_tb___024root.h"

VL_INLINE_OPT VlCoroutine Vspi_registers_tb___024root___eval_initial__TOP__Vtiming__0(Vspi_registers_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root___eval_initial__TOP__Vtiming__0\n"); );
    // Init
    IData/*31:0*/ __Vtask_spi_registers_tb__DOT__scoreboard__0__test_data;
    __Vtask_spi_registers_tb__DOT__scoreboard__0__test_data = 0;
    IData/*31:0*/ __Vtask_spi_registers_tb__DOT__driver__1__test_data;
    __Vtask_spi_registers_tb__DOT__driver__1__test_data = 0;
    // Body
    vlSelf->spi_registers_tb__DOT__rst_n = 0U;
    co_await vlSelf->__VdlySched.delay(2ULL, nullptr, 
                                       "testbench/spi_registers_tb.sv", 
                                       83);
    vlSelf->__Vm_traceActivity[2U] = 1U;
    vlSelf->spi_registers_tb__DOT__stimulus = 0U;
    vlSelf->spi_registers_tb__DOT__stimulus = (0xa045U 
                                               | (0xfff80000U 
                                                  & vlSelf->spi_registers_tb__DOT__stimulus));
    __Vtask_spi_registers_tb__DOT__scoreboard__0__test_data 
        = vlSelf->spi_registers_tb__DOT__stimulus;
    vlSelf->spi_registers_tb__DOT__unused = (1U & VL_REDXOR_32(
                                                               (__Vtask_spi_registers_tb__DOT__scoreboard__0__test_data 
                                                                >> 0x13U)));
    vlSelf->spi_registers_tb__DOT__expected_cpol = 
        (1U & __Vtask_spi_registers_tb__DOT__scoreboard__0__test_data);
    vlSelf->spi_registers_tb__DOT__expected_cpha = 
        (1U & (__Vtask_spi_registers_tb__DOT__scoreboard__0__test_data 
               >> 1U));
    vlSelf->spi_registers_tb__DOT__expected_msb = (1U 
                                                   & (__Vtask_spi_registers_tb__DOT__scoreboard__0__test_data 
                                                      >> 2U));
    vlSelf->spi_registers_tb__DOT__expected_bits = 
        (0xffU & (__Vtask_spi_registers_tb__DOT__scoreboard__0__test_data 
                  >> 3U));
    vlSelf->spi_registers_tb__DOT__expected_div_value 
        = (0xffU & (__Vtask_spi_registers_tb__DOT__scoreboard__0__test_data 
                    >> 0xbU));
    __Vtask_spi_registers_tb__DOT__driver__1__test_data 
        = vlSelf->spi_registers_tb__DOT__stimulus;
    vlSelf->spi_registers_tb__DOT__data = __Vtask_spi_registers_tb__DOT__driver__1__test_data;
    co_await vlSelf->__VtrigSched_hf5f61b83__0.trigger(0U, 
                                                       nullptr, 
                                                       "@(posedge spi_registers_tb.clk)", 
                                                       "testbench/spi_registers_tb.sv", 
                                                       50);
    vlSelf->__Vm_traceActivity[2U] = 1U;
    co_await vlSelf->__VdlySched.delay(1ULL, nullptr, 
                                       "testbench/spi_registers_tb.sv", 
                                       51);
    vlSelf->__Vm_traceActivity[2U] = 1U;
    if (VL_UNLIKELY(((IData)(vlSelf->spi_registers_tb__DOT__expected_cpol) 
                     != (IData)(vlSelf->spi_registers_tb__DOT__cpol)))) {
        VL_WRITEF("[%0t] %%Error: spi_registers_tb.sv:66: Assertion failed in %Nspi_registers_tb.compare_res: CPOL mismatch\n",
                  64,VL_TIME_UNITED_Q(1),-12,vlSymsp->name());
        VL_STOP_MT("testbench/spi_registers_tb.sv", 66, "");
    }
    if (VL_UNLIKELY(((IData)(vlSelf->spi_registers_tb__DOT__expected_cpha) 
                     != (IData)(vlSelf->spi_registers_tb__DOT__cpha)))) {
        VL_WRITEF("[%0t] %%Error: spi_registers_tb.sv:69: Assertion failed in %Nspi_registers_tb.compare_res: CPHA mismatch\n",
                  64,VL_TIME_UNITED_Q(1),-12,vlSymsp->name());
        VL_STOP_MT("testbench/spi_registers_tb.sv", 69, "");
    }
    if (VL_UNLIKELY(((IData)(vlSelf->spi_registers_tb__DOT__expected_msb) 
                     != (IData)(vlSelf->spi_registers_tb__DOT__msb)))) {
        VL_WRITEF("[%0t] %%Error: spi_registers_tb.sv:72: Assertion failed in %Nspi_registers_tb.compare_res: MSB mismatch\n",
                  64,VL_TIME_UNITED_Q(1),-12,vlSymsp->name());
        VL_STOP_MT("testbench/spi_registers_tb.sv", 72, "");
    }
    if (VL_UNLIKELY(((IData)(vlSelf->spi_registers_tb__DOT__expected_bits) 
                     != (IData)(vlSelf->spi_registers_tb__DOT__bits)))) {
        VL_WRITEF("[%0t] %%Error: spi_registers_tb.sv:75: Assertion failed in %Nspi_registers_tb.compare_res: BITS mismatch\n",
                  64,VL_TIME_UNITED_Q(1),-12,vlSymsp->name());
        VL_STOP_MT("testbench/spi_registers_tb.sv", 75, "");
    }
    if (VL_UNLIKELY(((IData)(vlSelf->spi_registers_tb__DOT__expected_div_value) 
                     != (IData)(vlSelf->spi_registers_tb__DOT__div_value)))) {
        VL_WRITEF("[%0t] %%Error: spi_registers_tb.sv:78: Assertion failed in %Nspi_registers_tb.compare_res: DIV_VALUE mismatch\n",
                  64,VL_TIME_UNITED_Q(1),-12,vlSymsp->name());
        VL_STOP_MT("testbench/spi_registers_tb.sv", 78, "");
    }
    VL_WRITEF("No errors\n");
    co_await vlSelf->__VdlySched.delay(0x64ULL, nullptr, 
                                       "testbench/spi_registers_tb.sv", 
                                       97);
    vlSelf->__Vm_traceActivity[2U] = 1U;
    VL_FINISH_MT("testbench/spi_registers_tb.sv", 98, "");
    vlSelf->__Vm_traceActivity[2U] = 1U;
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vspi_registers_tb___024root___dump_triggers__act(Vspi_registers_tb___024root* vlSelf);
#endif  // VL_DEBUG

void Vspi_registers_tb___024root___eval_triggers__act(Vspi_registers_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root___eval_triggers__act\n"); );
    // Body
    vlSelf->__VactTriggered.set(0U, (((IData)(vlSelf->spi_registers_tb__DOT__clk) 
                                      & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__spi_registers_tb__DOT__clk__0))) 
                                     | ((~ (IData)(vlSelf->spi_registers_tb__DOT__rst_n)) 
                                        & (IData)(vlSelf->__Vtrigprevexpr___TOP__spi_registers_tb__DOT__rst_n__0))));
    vlSelf->__VactTriggered.set(1U, vlSelf->__VdlySched.awaitingCurrentTime());
    vlSelf->__VactTriggered.set(2U, ((IData)(vlSelf->spi_registers_tb__DOT__clk) 
                                     & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__spi_registers_tb__DOT__clk__0))));
    vlSelf->__Vtrigprevexpr___TOP__spi_registers_tb__DOT__clk__0 
        = vlSelf->spi_registers_tb__DOT__clk;
    vlSelf->__Vtrigprevexpr___TOP__spi_registers_tb__DOT__rst_n__0 
        = vlSelf->spi_registers_tb__DOT__rst_n;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vspi_registers_tb___024root___dump_triggers__act(vlSelf);
    }
#endif
}
