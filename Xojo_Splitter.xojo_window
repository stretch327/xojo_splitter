#tag DesktopWindow
Begin DesktopContainer Xojo_Splitter
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   300
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   300
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  startx = x
		  starty = y
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(x As Integer, y As Integer)
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
		    ElseIf dx > 0 Then
		      // If moving right, check the controls on the right
		      For i = 0 To UBound(AfterControls)
		        If AfterControls(i).Width <= MinAfter Then 
		          Return
		        End If
		      Next i
		    End If
		    
		    // Move/Resize the controls
		    For i = 0 To UBound(BeforeControls)
		      BeforeControls(i).width = BeforeControls(i).width + dx
		    Next i
		    
		    For i = 0 To UBound(AfterControls)
		      AfterControls(i).Left = AfterControls(i).Left + dx
		      AfterControls(i).width = AfterControls(i).width - dx
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
		      
		    ElseIf dy > 0 Then
		      // if moving down, check the controls on the bottom
		      For i = 0 To UBound(AfterControls)
		        If AfterControls(i).height <= MinAfter Then 
		          Return
		        End If
		      Next i
		      
		    End If
		    
		    // Move/Resize the controls
		    For i = 0 To UBound(BeforeControls)
		      BeforeControls(i).height = BeforeControls(i).height + dy
		    Next i
		    
		    For i = 0 To UBound(AfterControls)
		      AfterControls(i).top = AfterControls(i).top + dy
		      AfterControls(i).height = AfterControls(i).height - dy
		    Next i
		    
		    Me.Top = Me.top + dy
		  End If
		  
		  // On Windows 2018r1 and later have the controls refresh to make them resize smoothly
		  #If TargetWindows And RBVersion > 2017.04
		    Self.Refresh
		    For i = 0 To UBound(BeforeControls)
		      BeforeControls(i).Refresh
		    Next
		    For i = 0 To UBound(AfterControls)
		      AfterControls(i).Refresh
		    Next
		  #EndIf
		  
		  SplitterMoved()
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseEnter()
		  If Me.Width < Me.Height Then
		    Me.MouseCursor = System.Cursors.ArrowEastWest
		  Else
		    Me.MouseCursor = System.Cursors.ArrowNorthSouth
		  end if
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  me.MouseCursor = nil
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddControlAfter(c as Object, minSize as integer = 0)
		  If Not CheckControlObject(c) Then
		    Raise New UnsupportedOperationException("The passed item is not a control or a container")
		  End If
		  
		  AfterControls.Append c
		  
		  self.minAfter = max(self.minAfter, minSize)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddControlBefore(c as Object, minSize as integer = 0)
		  If Not CheckControlObject(c) Then
		    Raise New UnsupportedOperationException("The passed item is not a control or a container")
		  End If
		  
		  BeforeControls.Append c
		  
		  Self.minBefore = Max(Self.minBefore, minSize)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CheckControlObject(obj as object) As Boolean
		  Select Case obj
		  Case IsA RectControl
		    Return True
		    
		  Case IsA ContainerControl
		    Return True
		    
		  Case IsA DesktopUIControl
		    Return True
		    
		  Case IsA DesktopContainer
		    Return True
		    
		  End Select
		  
		  return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawControl(gg as Graphics)
		  Dim p As Picture
		  dim g as Graphics
		  dim x,y as integer
		  
		  p = New Picture(gg.Width,gg.Height,32)
		  g = p.Graphics
		  
		  #if TargetMacOS then
		    g.ForeColor = ColorGroup.NamedColor("quaternaryLabelColor")
		    g.ClearRect 0, 0, g.Width, g.Height
		  #else
		    g.ForeColor = FillColor
		    g.FillRect 0,0,g.Width,g.Height
		  #endif
		  
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


	#tag Hook, Flags = &h0
		Event Paint(g As Graphics)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SplitterMoved()
	#tag EndHook


	#tag Property, Flags = &h21
		Private AfterControls() As MovableControl
	#tag EndProperty

	#tag Property, Flags = &h21
		Private BeforeControls() As MovableControl
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
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Visible=false
		Group="Position"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DragImage"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinAfter"
		Visible=false
		Group="Behavior"
		InitialValue="100"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinBefore"
		Visible=false
		Group="Behavior"
		InitialValue="100"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
