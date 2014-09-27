#!/bin/sh

func1() {
  echo "Now in func1"
  func2 123         # call func2() withy â123â as arg
}

func2() {
  echo "Now in func2"
  echo $1
}


echo "Start"
func1