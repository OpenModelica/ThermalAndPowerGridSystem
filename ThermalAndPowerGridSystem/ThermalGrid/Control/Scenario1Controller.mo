within ThermalAndPowerGridSystem.ThermalGrid.Control;

model Scenario1Controller
  extends ThermalAndPowerGridSystem.ThermalGrid.Icons.Control2;
  
  import Modelica.Units.SI.PerUnit;
  import AbsoluteTemperature = Modelica.Units.SI.Temperature;
  
  parameter AbsoluteTemperature T_DH = 348.15;
  parameter PerUnit thresholdPercentage;
  
  AbsoluteTemperature T_DH_L,T_DH_LL, T_DH_H, T_TES, T_SUP;
  Boolean mode1, mode2, mode3, mode4/* ,TESchargeMode*/;
 
  Modelica.Blocks.Interfaces.RealInput supplyTemperature annotation(
    Placement(visible = true, transformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {50, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput TESTemperature annotation(
    Placement(visible = true, transformation(origin = {-108, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-64, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
  Modelica.Blocks.Interfaces.BooleanOutput coldWaterSupplyBoilerControl annotation(
    Placement(visible = true, transformation(origin = {-164, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Interfaces.BooleanOutput bypassValveControl annotation(
    Placement(visible = true, transformation(origin = {-150, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Interfaces.BooleanOutput solarOutletValveControl annotation(
    Placement(visible = true, transformation(origin = {106, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput inletValveTEScontrol annotation(
    Placement(visible = true, transformation(origin = {106, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput outletPumpTEScontrol annotation(
    Placement(visible = true, transformation(origin = {-4, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
//  Modelica.Blocks.Interfaces.RealInput solarOutputTemperature annotation(
//    Placement(visible = true, transformation(origin = {-8, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-7, 111}, extent = {{-9, -9}, {9, 9}}, rotation = -90)));

algorithm
  when initial() then
    if T_SUP < T_DH_L then
      mode3 := true;
      mode1 := false;
      mode2 := false;
      mode4 := false;
   //   TESchargeMode := false;
    elseif T_SUP < T_DH_H then
      mode1 := true;
      mode2 := false;
      mode3 := false;
      mode4 := false;
  //    TESchargeMode := false;
    else
      mode4 := true;
      mode1 := false;
      mode2 := false;
      mode3 := false;
    //  TESchargeMode := false;
    end if;
  end when;
//             if T_TES>T_DH then
//                mode2 := true;
//                mode1 := false;
//                mode3 := false;
//                mode4 := false;
//            else
//           end if;
  when T_SUP > T_DH_H then
    mode4 := true;
    mode1 := false;
  end when;
   
   when T_SUP< T_DH then
        mode4 := false;
   end when;
//   when T_SUP>T_DH then
//        mode1 := true;
//        mode2 := false;
//   end when;
  when {T_SUP < T_DH_LL, T_SUP > T_DH_L} then
    mode3 := true;
    mode1 := false;
  end when;
//        if T_TES>T_DH_L and T_TES<T_DH_H then
//           mode2 := true;
//        else
//        end if;
  when T_SUP > T_DH then
    mode1 := true;
    mode3 := false;
  end when;
//          if mode2 then
//             mode2 := false;
//          else
//          end if;
//    when T_SUP<T_DH_L then
//         mode1 := false;
//    end when;

//when mode1 and solarOutputTemperature>T_DH then
//    TESchargeMode := true;
// end when;
 
// when solarOutputTemperature<T_DH_LL then
//   TESchargeMode := false;
// end when;
      
equation
  T_DH_L = 343.15;
/*(1- 0.01*thresholdPercentage)*T_DH;*/
  T_DH_H = 353.15;
/*(1+ 0.01*thresholdPercentage)*T_DH;*/
  T_DH_LL = 338.15;
/*(1- 0.02*thresholdPercentage)*T_DH;*/
  T_SUP = supplyTemperature;
  T_TES = TESTemperature;
  
//  if TESchargeMode then
//  inletValveTEScontrol = true;
//  else
//  inletValveTEScontrol = false;
//  end if;
  
  if mode1 then
   
    inletValveTEScontrol = true;
    coldWaterSupplyBoilerControl = false;
    bypassValveControl = false;
    solarOutletValveControl = true;
//    inletValveTEScontrol = false;
   
    outletPumpTEScontrol = false;
  elseif mode2 then
    coldWaterSupplyBoilerControl = false;
    bypassValveControl = false;
    solarOutletValveControl = true;
    inletValveTEScontrol = false;
    outletPumpTEScontrol = true;
  elseif mode3 then
    coldWaterSupplyBoilerControl = true;
    bypassValveControl = false;
    inletValveTEScontrol = true;
    solarOutletValveControl = false;
    outletPumpTEScontrol = false;
  //  inletValveTEScontrol = false;
  elseif mode4 then
    coldWaterSupplyBoilerControl = false;
    bypassValveControl = true;
    solarOutletValveControl = false;
    inletValveTEScontrol = true;
    outletPumpTEScontrol = false;
  else
    coldWaterSupplyBoilerControl = false;
    bypassValveControl = false;
    solarOutletValveControl = true;
   inletValveTEScontrol = false;
    outletPumpTEScontrol = false;
  end if;
end Scenario1Controller;
