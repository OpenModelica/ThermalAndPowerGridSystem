within ThermalAndPowerGridSystem.ThermalGrid.Control;

model SingleHouseController "Central Controller for Scenario1"
   extends ThermalAndPowerGridSystem.ThermalGrid.Control;
  
   import AbsoluteTemperature = Modelica.Units.SI.Temperature;
  parameter AbsoluteTemperature T_DH = 348.15 " District Heating Temperature SetPoint";
  parameter AbsoluteTemperature T_DH_L = 343.15 " DH Temperature Lower Limit";
  parameter AbsoluteTemperature T_DH_H = 353.15 "DH Temperature Higher Limit";
  
  AbsoluteTemperature T_SUP;
  Boolean modeSolar, modeBoiler, modeHeatBypass;
  
  Real  hour, days;
  Modelica.Blocks.Interfaces.RealInput supplyTemperature annotation(
    Placement(visible = true, transformation(origin = {-102, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-109, -1}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput pumpColdControl annotation(
    Placement(visible = true, transformation(origin = {104, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {106, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput pumpCold2Control annotation(
    Placement(visible = true, transformation(origin = {106, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {108, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput pumpBypassControl annotation(
    Placement(visible = true, transformation(origin = {108, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {108, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
algorithm
   when initial() then
        modeSolar := true; 
        modeBoiler := false; 
    end when;

    when T_SUP<T_DH_L then 
        modeBoiler := true;
        modeSolar := false;
   end when;
   
   when T_SUP>T_DH then
       modeBoiler := false;
       modeSolar := true;
   end when;
   
   when T_SUP> T_DH_H then
       modeSolar := false;
       modeHeatBypass := true;
   end when;
  
   when T_SUP<T_DH then
        modeHeatBypass := false;
    end when;    
   
equation
  days = div(time, 3600 * 24);
  hour = mod(div(time, 3600), 24);
  
  T_SUP = supplyTemperature;
  
  if hour >6-1e8 and hour<18+1e-8 and modeSolar then 
       pumpColdControl  = true;
       pumpCold2Control = false;
       pumpBypassControl = false;
  elseif modeBoiler then
       pumpCold2Control = true;
       pumpColdControl = false;
       pumpBypassControl = false;
  elseif modeHeatBypass then
       pumpColdControl = false;
       pumpCold2Control = false;
       pumpBypassControl = true;
   else 
       pumpColdControl = false;
       pumpCold2Control = true;
       pumpBypassControl = false;    
  end if;
 
end SingleHouseController;
