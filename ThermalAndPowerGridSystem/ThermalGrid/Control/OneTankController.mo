within ThermalAndPowerGridSystem.ThermalGrid.Control;

model OneTankController
extends Icons.Control;
 import Modelica.Units.SI.Height;

 parameter Height TankMaxHeight = 30;
 // Height HH = 0.95 * TankMaxHeight;
  Height H = 0.85 * TankMaxHeight;
  //  Height LL = 0.05 * TankMaxHeight;
  Height L = 0.10 * TankMaxHeight;
  
  Boolean stateEmpty "Tank Empty";      //States
  Boolean stateFull "Tank Full";
 Modelica.Blocks.Interfaces.RealInput tankLevel annotation(
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-107, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
 Modelica.Blocks.Interfaces.BooleanOutput pumpControl annotation(
    Placement(visible = true, transformation(origin = {113, -55}, extent = {{-13, -13}, {13, 13}}, rotation = 0), iconTransformation(origin = {107, 19}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
Modelica.Blocks.Interfaces.BooleanOutput valveControl annotation(
    Placement(visible = true, transformation(origin = {113, -89}, extent = {{-13, -13}, {13, 13}}, rotation = 0), iconTransformation(origin = {104, -40}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
 parameter Boolean initialState=true "True if tank is empty else full";
algorithm
 when initial() then
   stateEmpty := initialState;
    if initialState then
         pumpControl := false;
         valveControl :=true;
   else
         stateFull :=true;  
         pumpControl := true;
         valveControl :=false;    
   end if;       
 end when;
 
 if /*pre(stateEmpty) and*/ (tankLevel>=H) then
      stateEmpty := false;
      stateFull := true;
 end if;
 if pre(stateFull) and (tankLevel<=L) then
     stateEmpty := true;
     stateFull := false;
 end if;
  
 when stateEmpty then 
     pumpControl := false;
     valveControl := true; 
 elsewhen stateFull then 
    pumpControl := true;
    valveControl :=false;
 end when;   
 
annotation(
    Icon,
    experiment(StartTime = 0, StopTime = 500, Tolerance = 1e-6, Interval = 1));
end OneTankController;
