// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vspi_registers_tb__Syms.h"


void Vspi_registers_tb___024root__trace_chg_0_sub_0(Vspi_registers_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Vspi_registers_tb___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root__trace_chg_0\n"); );
    // Init
    Vspi_registers_tb___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vspi_registers_tb___024root*>(voidSelf);
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    Vspi_registers_tb___024root__trace_chg_0_sub_0((&vlSymsp->TOP), bufp);
}

void Vspi_registers_tb___024root__trace_chg_0_sub_0(Vspi_registers_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root__trace_chg_0_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    if (VL_UNLIKELY((vlSelf->__Vm_traceActivity[1U] 
                     | vlSelf->__Vm_traceActivity[2U]))) {
        bufp->chgBit(oldp+0,(vlSelf->spi_registers_tb__DOT__rst_n));
        bufp->chgIData(oldp+1,(vlSelf->spi_registers_tb__DOT__data),32);
        bufp->chgIData(oldp+2,(vlSelf->spi_registers_tb__DOT__stimulus),32);
        bufp->chgBit(oldp+3,(vlSelf->spi_registers_tb__DOT__expected_cpol));
        bufp->chgBit(oldp+4,(vlSelf->spi_registers_tb__DOT__expected_cpha));
        bufp->chgBit(oldp+5,(vlSelf->spi_registers_tb__DOT__expected_msb));
        bufp->chgCData(oldp+6,(vlSelf->spi_registers_tb__DOT__expected_bits),8);
        bufp->chgCData(oldp+7,(vlSelf->spi_registers_tb__DOT__expected_div_value),8);
        bufp->chgBit(oldp+8,(vlSelf->spi_registers_tb__DOT__unused));
    }
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[3U])) {
        bufp->chgBit(oldp+9,(vlSelf->spi_registers_tb__DOT__msb));
        bufp->chgBit(oldp+10,(vlSelf->spi_registers_tb__DOT__cpol));
        bufp->chgBit(oldp+11,(vlSelf->spi_registers_tb__DOT__cpha));
        bufp->chgCData(oldp+12,(vlSelf->spi_registers_tb__DOT__bits),8);
        bufp->chgCData(oldp+13,(vlSelf->spi_registers_tb__DOT__div_value),8);
        bufp->chgSData(oldp+14,(vlSelf->spi_registers_tb__DOT__dut__DOT__unused),13);
    }
    bufp->chgBit(oldp+15,(vlSelf->spi_registers_tb__DOT__clk));
}

void Vspi_registers_tb___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root__trace_cleanup\n"); );
    // Init
    Vspi_registers_tb___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vspi_registers_tb___024root*>(voidSelf);
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[2U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[3U] = 0U;
}
