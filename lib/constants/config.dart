// ignore: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/constants/app_colors.dart';

const TITLE = "The Heat is On";

// List of default towns
const town1 = {
  "id": "1",
  "name": "Town 1",
  "effortPoints": 100,
  "bushfire": {"nature": 40, "economy": 40, "society": 40, "health": 40},
  "flood": {"nature": 80, "economy": 80, "society": 80, "health": 80},
  "stormSurge": {"nature": 80, "economy": 80, "society": 80, "health": 80},
  "heatwave": {"nature": 60, "economy": 60, "society": 60, "health": 60},
  "biohazard": {"nature": 80, "economy": 80, "society": 80, "health": 80}
};

const town2 = {
  "id": "2",
  "name": "Town 2",
  "effortPoints": 100,
  "bushfire": {"nature": 60, "economy": 60, "society": 60, "health": 60},
  "flood": {"nature": 40, "economy": 40, "society": 40, "health": 40},
  "stormSurge": {"nature": 80, "economy": 80, "society": 80, "health": 80},
  "heatwave": {"nature": 80, "economy": 80, "society": 80, "health": 80},
  "biohazard": {"nature": 80, "economy": 80, "society": 80, "health": 80}
};

const town3 = {
  "id": "3",
  "name": "Town 3",
  "effortPoints": 100,
  "bushfire": {"nature": 80, "economy": 80, "society": 80, "health": 80},
  "flood": {"nature": 80, "economy": 80, "society": 80, "health": 80},
  "stormSurge": {"nature": 40, "economy": 40, "society": 40, "health": 40},
  "heatwave": {"nature": 80, "economy": 80, "society": 80, "health": 80},
  "biohazard": {"nature": 60, "economy": 60, "society": 60, "health": 60}
};

const town4 = {
  "id": "4",
  "name": "Town 4",
  "effortPoints": 100,
  "bushfire": {"nature": 80, "economy": 80, "society": 80, "health": 80},
  "flood": {"nature": 60, "economy": 60, "society": 60, "health": 60},
  "stormSurge": {"nature": 80, "economy": 80, "society": 80, "health": 80},
  "heatwave": {"nature": 40, "economy": 40, "society": 40, "health": 40},
  "biohazard": {"nature": 80, "economy": 80, "society": 80, "health": 80}
};

const town5 = {
  "id": "5",
  "name": "Town 5",
  "effortPoints": 100,
  "bushfire": {"nature": 80, "economy": 80, "society": 80, "health": 80},
  "flood": {"nature": 80, "economy": 80, "society": 80, "health": 80},
  "stormSurge": {"nature": 60, "economy": 60, "society": 60, "health": 60},
  "heatwave": {"nature": 80, "economy": 80, "society": 80, "health": 80},
  "biohazard": {"nature": 40, "economy": 40, "society": 40, "health": 40}
};

// Table titles
const hazardsTitle = [
  'Bushfire',
  'Flood',
  'Storm Surge',
  'Heatwave',
  'Biohazard',
];

const aspectsTitle = ['Nature', 'Economy', 'Society', 'Health'];

const hazardIds = [
  'bushfire',
  'flood',
  'stormSurge',
  'heatwave',
  'biohazard',
];

const aspectIds = ['nature', 'economy', 'society', 'health'];

// List of ability cards
const bushfire1 = {
  "id": "bushfire1",
  "type": "bushfire",
  "round": 1,
  "cost": 15,
  "nature": 20,
  "economy": 10,
  "society": 10,
  "health": 10
};

const bushfire2 = {
  "id": "bushfire2",
  "type": "bushfire",
  "round": 2,
  "cost": 15,
  "nature": 30,
  "economy": 10,
  "society": 10,
  "health": 10
};

const bushfire3 = {
  "id": "bushfire3",
  "type": "bushfire",
  "round": 3,
  "cost": 15,
  "nature": 10,
  "economy": 20,
  "society": 20,
  "health": 20
};

const flood1 = {
  "id": "flood1",
  "type": "flood",
  "round": 1,
  "cost": 15,
  "nature": 0,
  "economy": 20,
  "society": 15,
  "health": 15
};

const flood2 = {
  "id": "flood2",
  "type": "flood",
  "round": 2,
  "cost": 15,
  "nature": 30,
  "economy": 10,
  "society": 10,
  "health": 10
};

const flood3 = {
  "id": "flood3",
  "type": "flood",
  "round": 3,
  "cost": 15,
  "nature": 10,
  "economy": 20,
  "society": 20,
  "health": 20
};

const stormSurge1 = {
  "id": "stormSurge1",
  "type": "stormSurge",
  "round": 1,
  "cost": 15,
  "nature": 10,
  "economy": 20,
  "society": 10,
  "health": 10
};

const stormSurge2 = {
  "id": "stormSurge2",
  "type": "stormSurge",
  "round": 2,
  "cost": 15,
  "nature": 25,
  "economy": 15,
  "society": 10,
  "health": 10
};

const stormSurge3 = {
  "id": "stormSurge3",
  "type": "stormSurge",
  "round": 3,
  "cost": 15,
  "nature": 10,
  "economy": 20,
  "society": 20,
  "health": 20
};

const heatwave1 = {
  "id": "heatwave1",
  "type": "heatwave",
  "round": 1,
  "cost": 15,
  "nature": 10,
  "economy": 10,
  "society": 10,
  "health": 20
};

const heatwave2 = {
  "id": "heatwave2",
  "type": "heatwave",
  "round": 2,
  "cost": 15,
  "nature": 25,
  "economy": 10,
  "society": 10,
  "health": 15
};

const heatwave3 = {
  "id": "heatwave3",
  "type": "heatwave",
  "round": 3,
  "cost": 15,
  "nature": 10,
  "economy": 20,
  "society": 15,
  "health": 25
};

const biohazard1 = {
  "id": "biohazard1",
  "type": "biohazard",
  "round": 1,
  "cost": 15,
  "nature": 20,
  "economy": 10,
  "society": 10,
  "health": 10
};

const biohazard2 = {
  "id": "biohazard2",
  "type": "biohazard",
  "round": 2,
  "cost": 15,
  "nature": 0,
  "economy": 30,
  "society": 20,
  "health": 10
};

const biohazard3 = {
  "id": "biohazard3",
  "type": "biohazard",
  "round": 3,
  "cost": 15,
  "nature": 10,
  "economy": 20,
  "society": 20,
  "health": 20
};

const cards = [
  bushfire1,
  bushfire2,
  bushfire3,
  flood1,
  flood2,
  flood3,
  stormSurge1,
  stormSurge2,
  stormSurge3,
  heatwave1,
  heatwave2,
  heatwave3,
  biohazard1,
  biohazard2,
  biohazard3
];

const allNature = {
  "id": "allNature",
  "type": "nature",
  "round": 1,
  "cost": 15,
  "nature": 15,
  "economy": 15,
  "society": 15,
  "health": 15
};

const allEconomy = {
  "id": "allEconomy",
  "type": "economy",
  "round": 1,
  "cost": 15,
  "nature": 15,
  "economy": 15,
  "society": 15,
  "health": 15
};

const allSociety = {
  "id": "allSociety",
  "type": "society",
  "round": 1,
  "cost": 15,
  "nature": 15,
  "economy": 15,
  "society": 15,
  "health": 15
};

const allHealth = {
  "id": "allHealth",
  "type": "health",
  "round": 1,
  "cost": 15,
  "nature": 15,
  "economy": 15,
  "society": 15,
  "health": 15
};

const allAbilityCards = [allNature, allEconomy, allSociety, allHealth];

// List of hazards
const bushfire = {
  "id": "bushfire",
  "name": "Bushfire",
  "nature": 30,
  "economy": 10,
  "society": 20,
  "health": 20
};

const flood = {
  "id": "flood",
  "name": "Flood",
  "nature": 20,
  "economy": 30,
  "society": 15,
  "health": 15
};

const stormSurge = {
  "id": "stormSurge",
  "name": "Storm Surge",
  "nature": 20,
  "economy": 40,
  "society": 15,
  "health": 5
};

const heatwave = {
  "id": "heatwave",
  "name": "Heatwave",
  "nature": 20,
  "economy": 15,
  "society": 15,
  "health": 30
};

const biohazard = {
  "id": "biohazard",
  "name": "Biohazard",
  "nature": 5,
  "economy": 25,
  "society": 25,
  "health": 25
};

const hazards = [bushfire, flood, stormSurge, heatwave, biohazard];

const eventIcons = {
  'bushfire':
      Icon(Icons.local_fire_department, color: bushfireColor1, size: 36),
  'flood': Icon(Icons.cloud, color: floodColor1, size: 36),
  'stormSurge': Icon(Icons.cloudy_snowing, color: stormSurgeColor1, size: 36),
  'heatwave': Icon(Icons.wb_sunny, color: heatwaveColor1, size: 36),
  'biohazard': Icon(Icons.bug_report, color: biohazardColor1, size: 36),
};
