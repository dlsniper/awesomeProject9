package main

import "gopkg.in/yaml.v2"

type Demoer interface {
	Meth1()
	Meth2()
	Meth3()
}

type Demo struct {}
func (Demo) Meth1()  {}

type Demo2 struct {
	Demo
}

type Demo3 struct {
	Demo2
}
func (Demo) Meth2()  {}
func (Demo) Meth3()  {}

func main() {
	var a Demoer = Demo3{}
	_ = a

	_ = yaml.TypeError{}
}