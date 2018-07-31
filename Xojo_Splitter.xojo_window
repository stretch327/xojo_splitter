#tag Window
Begin ContainerControl Xojo_Splitter
   AcceptFocus     =   False
   AcceptTabs      =   False
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   100
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   32
   LockBottom      =   False
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   32
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   4
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  startx = x
		  starty = y
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  Dim dx, dy As Integer
		  Dim i As Integer
		  If Me.Width < Me.Height Then // Vertical
		    dx = x - startx
		    If dx < 0 Then
		      // If moving left, check the controls on the left
		      For i = 0 To UBound(BeforeControls)
		        If BeforeControls(i).Width <= MinBefore Then 
		          Return
		        End If
		      Next i
		      For i = 0 To UBound(BeforeContainers)
		        If BeforeContainers(i).Width <= MinBefore Then 
		          Return
		        End If
		      Next i
		    ElseIf dx > 0 Then
		      // If moving right, check the controls on the right
		      For i = 0 To UBound(AfterControls)
		        If AfterControls(i).Width <= MinAfter Then 
		          Return
		        End If
		      Next i
		      For i = 0 To UBound(AfterContainers)
		        If AfterContainers(i).Width <= MinAfter Then 
		          Return
		        End If
		      Next i
		    End If
		    
		    // Move/Resize the controls
		    For i = 0 To UBound(BeforeControls)
		      BeforeControls(i).width = BeforeControls(i).width + dx
		    Next i
		    For i = 0 To UBound(BeforeContainers)
		      BeforeContainers(i).width = BeforeContainers(i).width + dx
		    Next i
		    For i = 0 To UBound(AfterControls)
		      AfterControls(i).left = AfterControls(i).left + dx
		      AfterControls(i).width = AfterControls(i).width - dx
		    Next i
		    For i = 0 To UBound(AfterContainers)
		      AfterContainers(i).left = AfterContainers(i).left + dx
		      AfterContainers(i).width = AfterContainers(i).width - dx
		    Next i
		    Me.Left = Me.Left + dx
		  ElseIf Me.Height < Me.Width Then // Horizontal
		    dy = y - starty
		    
		    If dy < 0 Then
		      // If moving up, check the controls on the top
		      For i = 0 To UBound(BeforeControls)
		        If BeforeControls(i).height <= MinBefore Then 
		          Return
		        End If
		      Next i
		      For i = 0 To UBound(BeforeContainers)
		        If BeforeContainers(i).height <= MinBefore Then 
		          Return
		        End If
		      Next i
		    ElseIf dy > 0 Then
		      // if moving down, check the controls on the bottom
		      For i = 0 To UBound(AfterControls)
		        If AfterControls(i).height <= MinAfter Then 
		          Return
		        End If
		      Next i
		      For i = 0 To UBound(AfterContainers)
		        If AfterContainers(i).height <= MinAfter Then 
		          Return
		        End If
		      Next i
		    End If
		    
		    // Move/Resize the controls
		    For i = 0 To UBound(BeforeControls)
		      BeforeControls(i).height = BeforeControls(i).height + dy
		    Next i
		    For i = 0 To UBound(BeforeContainers)
		      BeforeContainers(i).height = BeforeContainers(i).height + dy
		    Next i
		    For i = 0 To UBound(AfterControls)
		      AfterControls(i).top = AfterControls(i).top + dy
		      AfterControls(i).height = AfterControls(i).height - dy
		    Next i
		    For i = 0 To UBound(AfterContainers)
		      AfterContainers(i).top = AfterContainers(i).top + dy
		      AfterContainers(i).height = AfterContainers(i).height - dy
		    Next i
		    Me.Top = Me.top + dy
		  End If
		  
		  // On Windows 2018r1 and above have the controls refresh to make them resize smoothly
		  #If TargetWindows And XojoVersion > 2017.04
		    Self.Refresh
		    For i = 0 To UBound(BeforeControls)
		      BeforeControls(i).Refresh
		    Next
		    For i = 0 To UBound(BeforeContainers)
		      BeforeContainers(i).Refresh
		    Next
		    For i = 0 To UBound(AfterControls)
		      AfterControls(i).Refresh
		    Next
		    For i = 0 To UBound(AfterContainers)
		      AfterContainers(i).Refresh
		    Next
		  #EndIf
		  
		  SplitterMoved()
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseEnter()
		  if me.Width < me.Height then
		    me.MouseCursor = system.Cursors.ArrowEastWest
		  else
		    me.MouseCursor = system.Cursors.ArrowNorthSouth
		  end if
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  me.MouseCursor = nil
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  DrawControl(g)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddControlAfter(c as ContainerControl, minSize as integer = 0)
		  AfterContainers.Append c
		  
		  self.minAfter = max(self.minAfter, minSize)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddControlAfter(c as RectControl, minSize as integer = 0)
		  AfterControls.Append c
		  
		  self.minAfter = max(self.minAfter, minSize)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddControlBefore(c as ContainerControl, minSize as integer = 0)
		  BeforeContainers.Append c
		  
		  self.minBefore = max(self.minBefore, minSize)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddControlBefore(c as RectControl, minSize as integer = 0)
		  BeforeControls.Append c
		  
		  self.minBefore = max(self.minBefore, minSize)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawControl(gg as Graphics)
		  dim p as Picture
		  dim g as Graphics
		  dim x,y as integer
		  
		  p = New Picture(gg.Width,gg.Height,32)
		  g = p.Graphics
		  
		  #if TargetMacOS then
		    g.ForeColor = &cEDEDED
		  #else
		    g.ForeColor = FillColor
		  #endif
		  g.FillRect 0,0,g.Width,g.Height
		  #if not TargetMacOS then
		    if gg.Width>=gg.Height then
		      gg.ForeColor = LightBevelColor
		      gg.DrawLine 0,0,g.Width,0
		      gg.ForeColor = DarkBevelColor
		      gg.DrawLine 0,g.Height,g.Width,g.Height
		    else
		      gg.ForeColor = LightBevelColor
		      gg.DrawLine 0,0,0,g.Height
		      gg.ForeColor = DarkBevelColor
		      gg.DrawLine g.Width,0,g.Width,g.Height
		    end if
		  #endif
		  if DragImage<>nil then
		    x = (gg.Width-DragImage.Width)/2
		    y = (gg.Height-DragImage.Height)/2
		    g.DrawPicture DragImage,x,y
		  end if
		  
		  Paint(g)
		  
		  gg.DrawPicture p,0,0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GetSplitterPic()
		  If DragImage = Nil Then
		    
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Paint(g as Graphics)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SplitterMoved()
	#tag EndHook


	#tag Property, Flags = &h21
		Private AfterContainers() As ContainerControl
	#tag EndProperty

	#tag Property, Flags = &h21
		Private AfterControls() As RectControl
	#tag EndProperty

	#tag Property, Flags = &h21
		Private BeforeContainers() As ContainerControl
	#tag EndProperty

	#tag Property, Flags = &h21
		Private BeforeControls() As RectControl
	#tag EndProperty

	#tag Property, Flags = &h0
		DragImage As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		MinAfter As Integer = 100
	#tag EndProperty

	#tag Property, Flags = &h0
		MinBefore As Integer = 100
	#tag EndProperty

	#tag Property, Flags = &h21
		Private StartX As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private StartY As Integer
	#tag EndProperty


#tag EndWindowCode

#tag ViewBehavior
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Group="Position"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Position"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Position"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="UseFocusRing"
		Visible=true
		Group="Appearance"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AcceptFocus"
		Group="Behavior"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AcceptTabs"
		Group="Behavior"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Group="Behavior"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="DragImage"
		Visible=true
		Group="Behavior"
		Type="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinBefore"
		Visible=true
		Group="Behavior"
		InitialValue="100"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinAfter"
		Visible=true
		Group="Behavior"
		InitialValue="100"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
#tag EndViewBehavior
