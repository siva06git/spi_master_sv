// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vspi_registers_tb.h for the primary calling header

#include "Vspi_registers_tb__pch.h"
#include "Vspi_registers_tb__Syms.h"
#include "Vspi_registers_tb___024root.h"

VL_ATTR_COLD void Vspi_registers_tb___024root___eval_initial__TOP(Vspi_registers_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vspi_registers_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vspi_registers_tb___024root___eval_initial__TOP\n"); );
    // Init
    VlWide<6>/*191:0*/ __Vtemp_1;
    // Body
    __Vtemp_1[0U] = 0x2e766364U;
    __Vtemp_1[1U] = 0x74657273U;
    __Vtemp_1[2U] = 0x65676973U;
    __Vtemp_1[3U] = 0x70695f72U;
    __Vtemp_1[4U] = 0x75742f73U;
    __Vtemp_1[5U] = 0x6f757470U;
    vlSymsp->_vm_contextp__->dumpfile(VL_CVT_PACK_STR_NW(6, __Vtemp_1));
    vlSymsp->_traceDumpOpen();
}
