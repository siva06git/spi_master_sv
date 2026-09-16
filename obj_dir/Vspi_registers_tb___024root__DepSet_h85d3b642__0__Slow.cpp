// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vspi_registers_tb.h for the primary calling header

#include "Vspi_registers_tb__pch.h"
#include "Vspi_registers_tb___024root.h"

VL_ATTR_COLD void Vspi_registers_tb___024root___eval_static(Vspi_registers_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root___eval_static\n"); );
}

VL_ATTR_COLD void Vspi_registers_tb___024root___eval_final(Vspi_registers_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root___eval_final\n"); );
}

VL_ATTR_COLD void Vspi_registers_tb___024root___eval_settle(Vspi_registers_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root___eval_settle\n"); );
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vspi_registers_tb___024root___dump_triggers__act(Vspi_registers_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VactTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @(posedge spi_registers_tb.clk or negedge spi_registers_tb.rst_n)\n");
    }
    if ((2ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 1 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
    if ((4ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 2 is active: @(posedge spi_registers_tb.clk)\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vspi_registers_tb___024root___dump_triggers__nba(Vspi_registers_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root___dump_triggers__nba\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VnbaTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @(posedge spi_registers_tb.clk or negedge spi_registers_tb.rst_n)\n");
    }
    if ((2ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 1 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
    if ((4ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 2 is active: @(posedge spi_registers_tb.clk)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vspi_registers_tb___024root___ctor_var_reset(Vspi_registers_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->spi_registers_tb__DOT__clk = VL_RAND_RESET_I(1);
    vlSelf->spi_registers_tb__DOT__rst_n = VL_RAND_RESET_I(1);
    vlSelf->spi_registers_tb__DOT__data = VL_RAND_RESET_I(32);
    vlSelf->spi_registers_tb__DOT__msb = VL_RAND_RESET_I(1);
    vlSelf->spi_registers_tb__DOT__cpol = VL_RAND_RESET_I(1);
    vlSelf->spi_registers_tb__DOT__cpha = VL_RAND_RESET_I(1);
    vlSelf->spi_registers_tb__DOT__bits = VL_RAND_RESET_I(8);
    vlSelf->spi_registers_tb__DOT__div_value = VL_RAND_RESET_I(8);
    vlSelf->spi_registers_tb__DOT__stimulus = VL_RAND_RESET_I(32);
    vlSelf->spi_registers_tb__DOT__expected_cpol = VL_RAND_RESET_I(1);
    vlSelf->spi_registers_tb__DOT__expected_cpha = VL_RAND_RESET_I(1);
    vlSelf->spi_registers_tb__DOT__expected_msb = VL_RAND_RESET_I(1);
    vlSelf->spi_registers_tb__DOT__expected_bits = VL_RAND_RESET_I(8);
    vlSelf->spi_registers_tb__DOT__expected_div_value = VL_RAND_RESET_I(8);
    vlSelf->spi_registers_tb__DOT__unused = VL_RAND_RESET_I(1);
    vlSelf->spi_registers_tb__DOT__dut__DOT__unused = VL_RAND_RESET_I(13);
    vlSelf->__Vdlyvval__spi_registers_tb__DOT__clk__v0 = VL_RAND_RESET_I(1);
    vlSelf->__Vdlyvset__spi_registers_tb__DOT__clk__v0 = 0;
    vlSelf->__Vtrigprevexpr___TOP__spi_registers_tb__DOT__clk__0 = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigprevexpr___TOP__spi_registers_tb__DOT__rst_n__0 = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = 0;
    }
}
