within ThermalAndPowerGridSystem.ThermalGrid.Control;

model TwoTankController
  import Modelica.Units.SI.Height;

//State Machine to control flow betweenhot and cold water storage tanks
  parameter Height hotTankMaxHeight = 30;
  parameter Height coldTankMaxHeight = 30;
  Height hotHH = 0.95 * hotTankMaxHeight;
  Height hotH = 0.9 * hotTankMaxHeight;
  Height hotLL = 0.05 * hotTankMaxHeight;
  Height hotL = 0.10 * hotTankMaxHeight;
  Height coldHH = 0.95 * coldTankMaxHeight;
  Height coldH = 0.90 * coldTankMaxHeight;
  Height coldLL = 0.05 * coldTankMaxHeight;
  Height coldL = 0.10 * coldTankMaxHeight;
  /*
  Initially Hot Storage Tank is empty(state0)... Cold Storage Tank is full(stateA).

  When hot storage tank was previously in empty state , and no level exists, switch on valveCCP, switch off valveHCP and switch to hot tank full(state1)
  When hot storage tank was previously full and level has become full, switch off valveCCP and switch to hot tank empty(state0);

  When cold storage tank is previously full state, and level is high,  switch off valveHCP, switch on valveCCP and switch to cold tank empty(stateB)
  When cold storage tank is previously empty state, and level is low, switch off valveCCP and switch on valveHCP and switch to cold tank full(stateA).
  */
  //States
  Boolean state0 "Hot Tank Empty";
  Boolean state1 "Hot Tank Full";
  Boolean stateA "Cold Tank Full";
  Boolean stateB "Cold Tank Empty";
  //Effects
   Modelica.Blocks.Interfaces.BooleanOutput valveHCP annotation(
    Placement(visible = true, transformation(origin = {110, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
   Modelica.Blocks.Interfaces.BooleanOutput valveCCP annotation(
    Placement(visible = true, transformation(origin = {110, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
   Modelica.Blocks.Interfaces.RealInput levelHot annotation(
    Placement(visible = true, transformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
   Modelica.Blocks.Interfaces.RealInput levelCold annotation(
    Placement(visible = true, transformation(origin = {-110, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 algorithm
  when initial() then
    state0 := true;
    stateA := true;
    valveCCP := true;
    valveHCP := false;
  end when;
//Hot tank empty
//Cold tank full
  if pre(state0) and levelHot >= hotH then
    state0 := false;
    state1 := true;
  elseif pre(state1) and levelHot <= hotL then
    state1 := false;
    state0 := true;
  end if;
  if pre(stateA) and levelCold < coldL then
    stateA := false;
    stateB := true;
  elseif pre(stateB) and levelCold > coldH then
    stateB := false;
    stateA := true;
  end if;
  when state0 or stateA then
    valveCCP := true;
    valveHCP := false;
  elsewhen state1 or stateB then
    valveHCP := true;
    valveCCP := false;
  end when;
annotation(
    Icon(graphics = {Text(origin = {3, -49}, lineColor = {85, 0, 255}, extent = {{-93, 87}, {93, -87}}, textString = "Tank Controller", fontName = "Calibri Light", textStyle = {TextStyle.Bold}), Rectangle(origin = {-0.01, -50.51}, pattern = LinePattern.Dash, lineThickness = 0.75, extent = {{-100.01, 49.49}, {100.01, -49.49}})}));
end TwoTankController;
