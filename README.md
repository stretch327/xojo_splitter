# Xojo_Splitter
Splitter control for Xojo written in pure xojo code.

# Usage
1. Drag the xojo_splitter control into your project.
2. Drag the Xojo_Splitter control to a window and place between two or more controls.
3. In the splitter's Open event define the controls that come before and after the splitter:

`Self.AddControlBefore(TextField1)`
`Self.AddControlAfter(Listbox1)`

You can also control how small controls are allowed to get either by setting:

* MinBefore and MinAfter properties in the Inspector in the Xojo IDE.
* MinBefore and MinAfter properties via code.
* Minimum sizes when you add a control to the splitter:

`Self.AddControlBefore(TextField1, 200)`
`Self.AddControlAfter(Listbox1, 300)`