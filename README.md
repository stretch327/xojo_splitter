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

# Extras
By default, the splitter has no drag image associated with it. If you want to have an indicator visible to show users where to drag, put the picture into the DragImage property. It will be automatically centered in the splitter. 

Alternatively, you may wish to implement the Paint event on the your control instance for more complicated drawing needs.

# Events
As mentioned above, the Paint event will allow you to draw whatever you want within the bounds of the splitter.

There is also a SplitterMoved event which fires whenever the splitter is moved by the user.