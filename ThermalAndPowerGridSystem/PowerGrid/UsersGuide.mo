within ThermalAndPowerGridSystem.PowerGrid;

package UsersGuide "User's Guide"
  extends ThermalAndPowerGridSystem.PowerGrid.Icons.Information_Icon;

  class Overview "Overview of Power Grid"
    extends ThermalAndPowerGridSystem.PowerGrid.Icons.Information_Icon;
  
   annotation (Documentation(info = "<html><head></head><body><br><div>It is a package which has Wind energy and Solar energy as sources of Electrical Power generation. It has one Electricity storage system to store generated power, two electricity consumption systems namely DomesticConsumer and ChargingStation, and one convention grid for power in and out. This Power Grid package is simulated for a year(365 days or&nbsp;3.1536e+07 seconds), considering a&nbsp;<b>Town Scenario</b> as one Grid Scenario. Parameters needed for this simulation are wind Speed, turbine Rotor Radius, its efficiency, solarPowerData for every month, pvSurfaceArea and it efficiency. Simulation under&nbsp;<b>TownScenario</b>&nbsp;is governed by different equations such as demand and generation of electricity, status of energyStorage FLAG, which will lets us know how much Electrical power needs to be transferred to the grid. There are many more equations which changes according to consumer demand, stored energy and Electrical power generated.</div><div><br></div><div><b><u>System Parameters</u></b></div>
<div><br></div><div><p>This section describes how parameters are placed and how it can be changed to get different values to get diffrent scenarios.</p><p>All parameters are placed in&nbsp;<i>Record</i>&nbsp;files<i>&nbsp;</i>with its name&nbsp;<i><a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Utilities.SystemParameters\">SystemParameters</a>.</i></p><p>Record files can be found in&nbsp;<a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Utilities\">Utlilities</a>.</p></div><div><br></div><div><b><u>How to Simulate this package</u></b></div><div><ul><li>Start with Simulating <a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.GridScenarios.TownScenario\">TownScenario</a> with all preset start and stop time.</li><li>Start by plotting&nbsp;<span style=\"font-family: 'DejaVu Sans Mono';\"><i>availableGeneratedPower,&nbsp;totalDemandPower,&nbsp;powerTransferedToStorage </i>and&nbsp;<i>powerTransferedToGrid&nbsp;</i>from <a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Components.PowerManagementSystem\">PowerManagmentSystem</a>, demand should always be met from generated power and/or storage and/or grid.</span></li><li><font face=\"DejaVu Sans Mono\">Variables from <a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Components.Kpi\">Kpi</a> can be used to monitor key performance index of the simulation.</font></li></ul></div></body></html>"));
  end Overview;
  
  package ReleaseNotes "Release notes"
    extends ThermalAndPowerGridSystem.PowerGrid.Icons.ReleaseNotes_Icon;
   annotation (Documentation(info= "<html><head></head><body><p>
  This section summarizes the changes that have been performed
  on the Power Grid library.
  </p>
  
  <table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tbody><tr><td><a>Version&nbsp;0.0</a></td><td>December 10 2021</td></tr>
 </tbody></table><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\"><tbody><tr><td><a>Version 1.0.0</a></td><td>May 22 2022</td></tr></tbody></table><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\"><tbody><tr><td><a>Version 1.0.1</a></td><td>July 01 2022</td></tr></tbody></table></body></html>"));
  end ReleaseNotes;

class Contact "Contact"
  extends ThermalAndPowerGridSystem.PowerGrid.Icons.Contact_Icon;

 annotation (Documentation(info= "<html><head></head><body><dl><dd><p><span style=\"font-weight: normal;\"><br></span></p><h3 style=\"font-family: 'MS Shell Dlg 2';\"><font color=\"#008000\" size=\"5\">Contact</font></h3><dl style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><h3>Developed by Modelicon Infotech for Linköping University</h3><dd>Email:&nbsp;<a href=\"mailto:sunil.shah@modelicon.in\">sunil.shah@modelicon.in</a></dd><dd>Email:&nbsp;<a href=\"mailto:sunilshah@outlook.com\">sunilshah@outlook.com</a><br></dd></dl><p><span style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\">&nbsp; Developers: Sunil Shah<br></span><span style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span><span style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\">Ajeya B<br></span><span style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Manish<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span><span style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\">Reshma R</span></p></dd><dd></dd></dl>

</body></html>"));

end Contact;

annotation (DocumentationClass=true, Documentation(info= "<html><head></head><body><p>This package has been developed to Simulate Different Power Grid scenarios for Green Energy where all power generation is from Renewable Resources. This package is a model of physical environment which consists of two power generation source (such as <b>Wind Farm</b> and <b>Solar Farm</b>) and two power demand sinks (such as<b> Domestic Demand</b> and <b>Charging Station</b> (under devlopment)), there is a <b>Power Storage Unit</b> and <b>Infinite Source/Sink Grid </b>to fullfil demand when there is no Power generation.</p>
<p>This packages contains different sub-packages:</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tbody><tr>
  <td><a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Icons\">Icons</a></td>
  <td>It contains all Icons required for this sub-package.</td>
</tr>

<tr><td><a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Interfaces\">Interfaces</a></td>
   <td>Electrical port is in this sub-package.</td>
   
</tr>

<tr>
  <td><a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Utilities\">Utilities</a><br></td>
  <td>It contains parameters and data.</td>
</tr>

<tr><td><a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Components\">Components</a></td>
    <td>Contains all required components for this package.</td>
</tr>

<tr>
  <td><a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.GridScenarios\">GridScenarios</a></td>
  <td>Contains Scenarios</td>
</tr>
</tbody></table>
<div><br></div><div><b>Objects inside </b><b><a href=\"ThermalAndPowerGridmodelica://System.PowerGrid.Interfaces\">Interfaces</a></b></div>



<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tbody><tr>
  <td><a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Interfaces.ElectricalPort\">ElectricalPort</a></td>
  <td>Used for connection between two Objects to tranfer <i>Voltage</i> and <i>Power</i></td>
</tr>

</tbody>
</table>
<br><div><b>Objects inside <a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Utilities\">Utilities</a></b></div>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tbody><tr>
  <td><a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Utilities.SystemParameters\">SystemParameters</a></td>
  <td>Contains all Parameters in a single Record file</td>
</tr>
<tr>
  <td><a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Utilities.SolarPowerData\">SolarPowerData</a></td>
  <td>Solar data such as solar irradiance is taken from text file using this object&nbsp;</td>
</tr>
<tr>
  <td><a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Utilities.WindPowerData\">WindPowerData</a></td>
  <td>Wind data such as wind speed is taken from text file using this object&nbsp;</td>
</tr>
</tbody>
</table>

<br><div><b>Objects inside <a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Components\">Components</a></b></div>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tbody><tr>
  <td><a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Components.PowerManagementSystem\">PowerManagementSystem</a></td>
  <td>This component comprises of Power Management logic to manage demand</td>
</tr>
<tr>
  <td><a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Components.EnergyStorage\">EnergyStorage</a></td>
  <td>This component store Energy when generation is more than demand and supply to demand when generation is less than demand</td>
</tr>
<tr>
  <td><a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Components.DomesticConsumer\">DomesticConsumer</a></td>
  <td>This component comprises of power requirnment from domestic consumer. Combitable power input should be in kW.</td>
</tr>
<tr>
  <td><a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Components.ChargingStation\">ChargingStation</a></td>
  <td>This component comprises of power requirnment from Charging Station consumer. I<span style=\"font-family: 'DejaVu Sans Mono'; font-size: 12px;\">t is not a realistic model, its purpose is only to emphasize on the ability of the modeling platform.</span></td>
</tr>
<tr>
  <td><a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Components.ConventionalGrid\">ConventionalGrid</a></td>
  <td>This component comprises infinite power source/sink</td></tr><tr><td><a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Components.WindFarm\">WindFarm</a></td>
  <td>This component comprises of wind turbines generating electrical power from wind energy</td></tr><tr><td><a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Components.SolarFarm\">SolarFarm</a></td>
  <td>This component comprises of PV panels generating electrical power from solar energy</td>
</tr>
<tr>
  <td><a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.Components.Kpi\">Kpi</a></td>
  <td>This component comprises Key Performance Indicators</td>
</tr>

</tbody>
</table>
<br><div><b>Objects inside <a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.GridScenarios\">GridScenarios</a></b></div>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tbody><tr>
  <td><a href=\"modelica://ThermalAndPowerGridSystem.PowerGrid.GridScenarios.TownScenario\">TownScenario</a></td>
  <td>This example comprises of a simple town scenario</td>
</tr>
</tbody>
</table>

</body></html>"));
end UsersGuide;
