#tag Class
Protected Class MovableControl
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(c as object)
		  mControl = c
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Select Case mControl
			  Case IsA RectControl
			    Return RectControl(mControl).Height
			  Case IsA DesktopUIControl
			    Return DesktopUIControl(mControl).Height
			  Case IsA ContainerControl
			    Return ContainerControl(mControl).Height
			  Case IsA DesktopContainer
			    Return DesktopContainer(mControl).Height
			  End Select
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Select Case mControl
			  Case IsA RectControl
			    RectControl(mControl).Height = value
			  Case IsA DesktopUIControl
			    DesktopUIControl(mControl).Height = value
			  Case IsA ContainerControl
			    ContainerControl(mControl).Height = value
			  Case IsA DesktopContainer
			    DesktopContainer(mControl).Height = value
			  End Select
			End Set
		#tag EndSetter
		Height As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Select Case mControl
			  Case IsA RectControl
			    Return RectControl(mControl).Left
			  Case IsA DesktopUIControl
			    Return DesktopUIControl(mControl).Left
			  Case IsA ContainerControl
			    Return ContainerControl(mControl).Left
			  Case IsA DesktopContainer
			    Return DesktopContainer(mControl).Left
			  End Select
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Select Case mControl
			  Case IsA RectControl
			    RectControl(mControl).Left = value
			  Case IsA DesktopUIControl
			    DesktopUIControl(mControl).Left = value
			  Case IsA ContainerControl
			    ContainerControl(mControl).Left = value
			  Case IsA DesktopContainer
			    DesktopContainer(mControl).Left = value
			  End Select
			End Set
		#tag EndSetter
		Left As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mControl As Object
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Select Case mControl
			  Case IsA RectControl
			    Return RectControl(mControl).Top
			  Case IsA DesktopUIControl
			    Return DesktopUIControl(mControl).Top
			  Case IsA ContainerControl
			    Return ContainerControl(mControl).Top
			  Case IsA DesktopContainer
			    Return DesktopContainer(mControl).Top
			  End Select
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Select Case mControl
			  Case IsA RectControl
			    RectControl(mControl).Top = value
			  Case IsA DesktopUIControl
			    DesktopUIControl(mControl).Top = value
			  Case IsA ContainerControl
			    ContainerControl(mControl).Top = value
			  Case IsA DesktopContainer
			    DesktopContainer(mControl).Top = value
			  End Select
			End Set
		#tag EndSetter
		Top As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Select Case mControl
			  Case IsA RectControl
			    Return RectControl(mControl).Width
			  Case IsA DesktopUIControl
			    Return DesktopUIControl(mControl).Width
			  Case IsA ContainerControl
			    Return ContainerControl(mControl).Width
			  Case IsA DesktopContainer
			    Return DesktopContainer(mControl).Width
			  End Select
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Select Case mControl
			  Case IsA RectControl
			    RectControl(mControl).Width = value
			  Case IsA DesktopUIControl
			    DesktopUIControl(mControl).Width = value
			  Case IsA ContainerControl
			    ContainerControl(mControl).Width = value
			  Case IsA DesktopContainer
			    DesktopContainer(mControl).Width = value
			  End Select
			End Set
		#tag EndSetter
		Width As Integer
	#tag EndComputedProperty


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
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Width"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
