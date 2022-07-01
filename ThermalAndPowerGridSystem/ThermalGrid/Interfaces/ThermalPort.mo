within ThermalAndPowerGridSystem.ThermalGrid.Interfaces;

connector ThermalPort "Thermal connector"
  Modelica.Units.SI.Temperature T "Temperature";
  flow Modelica.Units.SI.HeatFlowRate W "Thermal flow rate. Positive when going into the component";
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(lineColor = {255, 0, 0}, fillColor = {255, 20, 83}, fillPattern = FillPattern.Sphere, extent = {{-100, 100}, {100, -100}})}),
    Window(
      x=0.12,
      y=0.27,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end ThermalPort;
