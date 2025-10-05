## Base class for Triggers such as Buttons and Switches
extends Area2D
class_name Trigger

## Items which this trigger will activate
@export var connected_items: Array[Triggerable]

const TRIGGER_TIME = 0.3

signal state_changed(on: bool)
