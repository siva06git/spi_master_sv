// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vspi_registers_tb.h for the primary calling header

#include "Vspi_registers_tb__pch.h"
#include "Vspi_registers_tb___024root.h"

VL_ATTR_COLD void Vspi_registers_tb___024root___eval_initial__TOP(Vspi_registers_tb___024root* vlSelf);
VlCoroutine Vspi_registers_tb___024root___eval_initial__TOP__Vtiming__0(Vspi_registers_tb___024root* vlSelf);
VlCoroutine Vspi_registers_tb___024root___eval_initial__TOP__Vtiming__1(Vspi_registers_tb___024root* vlSelf);

void Vspi_registers_tb___024root___eval_initial(Vspi_registers_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root___eval_initial\n"); );
    // Body
    Vspi_registers_tb___024root___eval_initial__TOP(vlSelf);
    vlSelf->__Vm_traceActivity[1U] = 1U;
    Vspi_registers_tb___024root___eval_initial__TOP__Vtiming__0(vlSelf);
    Vspi_registers_tb___024root___eval_initial__TOP__Vtiming__1(vlSelf);
    vlSelf->__Vtrigprevexpr___TOP__spi_registers_tb__DOT__clk__0 
        = vlSelf->spi_registers_tb__DOT__clk;
    vlSelf->__Vtrigprevexpr___TOP__spi_registers_tb__DOT__rst_n__0 
        = vlSelf->spi_registers_tb__DOT__rst_n;
}

VL_INLINE_OPT VlCoroutine Vspi_registers_tb___024root___eval_initial__TOP__Vtiming__1(Vspi_registers_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root___eval_initial__TOP__Vtiming__1\n"); );
    // Body
    while (1U) {
        co_await vlSelf->__VdlySched.delay(5ULL, nullptr, 
                                           "testbench/spi_registers_tb.sv", 
                                           33);
        vlSelf->__Vdlyvval__spi_registers_tb__DOT__clk__v0 
            = (1U & (~ (IData)(vlSelf->spi_registers_tb__DOT__clk)));
        vlSelf->__Vdlyvset__spi_registers_tb__DOT__clk__v0 = 1U;
    }
}

void Vspi_registers_tb___024root___eval_act(Vspi_registers_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root___eval_act\n"); );
}

VL_INLINE_OPT void Vspi_registers_tb___024root___nba_sequent__TOP__0(Vspi_registers_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root___nba_sequent__TOP__0\n"); );
    // Body
    if (vlSelf->__Vdlyvset__spi_registers_tb__DOT__clk__v0) {
        vlSelf->spi_registers_tb__DOT__clk = vlSelf->__Vdlyvval__spi_registers_tb__DOT__clk__v0;
        vlSelf->__Vdlyvset__spi_registers_tb__DOT__clk__v0 = 0U;
    }
}

VL_INLINE_OPT void Vspi_registers_tb___024root___nba_sequent__TOP__1(Vspi_registers_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root___nba_sequent__TOP__1\n"); );
    // Body
    vlSelf->spi_registers_tb__DOT__dut__DOT__unused 
        = (vlSelf->spi_registers_tb__DOT__data >> 0x13U);
    vlSelf->spi_registers_tb__DOT__div_value = (0xffU 
                                                & (vlSelf->spi_registers_tb__DOT__data 
                                                   >> 0xbU));
    vlSelf->spi_registers_tb__DOT__bits = (0xffU & 
                                           (vlSelf->spi_registers_tb__DOT__data 
                                            >> 3U));
    vlSelf->spi_registers_tb__DOT__msb = (1U & (vlSelf->spi_registers_tb__DOT__data 
                                                >> 2U));
    if ((1U & (~ (IData)(vlSelf->spi_registers_tb__DOT__rst_n)))) {
        vlSelf->spi_registers_tb__DOT__cpha = 0U;
        vlSelf->spi_registers_tb__DOT__cpol = 0U;
    }
    vlSelf->spi_registers_tb__DOT__cpha = (1U & (vlSelf->spi_registers_tb__DOT__data 
                                                 >> 1U));
    vlSelf->spi_registers_tb__DOT__cpol = (1U & vlSelf->spi_registers_tb__DOT__data);
}

void Vspi_registers_tb___024root___eval_nba(Vspi_registers_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root___eval_nba\n"); );
    // Body
    if ((2ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vspi_registers_tb___024root___nba_sequent__TOP__0(vlSelf);
    }
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vspi_registers_tb___024root___nba_sequent__TOP__1(vlSelf);
        vlSelf->__Vm_traceActivity[3U] = 1U;
    }
}

void Vspi_registers_tb___024root___timing_resume(Vspi_registers_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root___timing_resume\n"); );
    // Body
    if ((4ULL & vlSelf->__VactTriggered.word(0U))) {
        vlSelf->__VtrigSched_hf5f61b83__0.resume("@(posedge spi_registers_tb.clk)");
    }
    if ((2ULL & vlSelf->__VactTriggered.word(0U))) {
        vlSelf->__VdlySched.resume();
    }
}

void Vspi_registers_tb___024root___timing_commit(Vspi_registers_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root___timing_commit\n"); );
    // Body
    if ((! (4ULL & vlSelf->__VactTriggered.word(0U)))) {
        vlSelf->__VtrigSched_hf5f61b83__0.commit("@(posedge spi_registers_tb.clk)");
    }
}

void Vspi_registers_tb___024root___eval_triggers__act(Vspi_registers_tb___024root* vlSelf);

bool Vspi_registers_tb___024root___eval_phase__act(Vspi_registers_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root___eval_phase__act\n"); );
    // Init
    VlTriggerVec<3> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    Vspi_registers_tb___024root___eval_triggers__act(vlSelf);
    Vspi_registers_tb___024root___timing_commit(vlSelf);
    __VactExecute = vlSelf->__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
        vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
        Vspi_registers_tb___024root___timing_resume(vlSelf);
        Vspi_registers_tb___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool Vspi_registers_tb___024root___eval_phase__nba(Vspi_registers_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root___eval_phase__nba\n"); );
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelf->__VnbaTriggered.any();
    if (__VnbaExecute) {
        Vspi_registers_tb___024root___eval_nba(vlSelf);
        vlSelf->__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vspi_registers_tb___024root___dump_triggers__nba(Vspi_registers_tb___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vspi_registers_tb___024root___dump_triggers__act(Vspi_registers_tb___024root* vlSelf);
#endif  // VL_DEBUG

void Vspi_registers_tb___024root___eval(Vspi_registers_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root___eval\n"); );
    // Init
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
            Vspi_registers_tb___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("testbench/spi_registers_tb.sv", 3, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                Vspi_registers_tb___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("testbench/spi_registers_tb.sv", 3, "", "Active region did not converge.");
            }
            vlSelf->__VactIterCount = ((IData)(1U) 
                                       + vlSelf->__VactIterCount);
            vlSelf->__VactContinue = 0U;
            if (Vspi_registers_tb___024root___eval_phase__act(vlSelf)) {
                vlSelf->__VactContinue = 1U;
            }
        }
        if (Vspi_registers_tb___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void Vspi_registers_tb___024root___eval_debug_assertions(Vspi_registers_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root___eval_debug_assertions\n"); );
}
#endif  // VL_DEBUG
