<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class VBSerialForm
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Me.StatusStrip = New System.Windows.Forms.StatusStrip()
        Me.SerialComStatusLabel = New System.Windows.Forms.ToolStripStatusLabel()
        Me.SerialSetupGroupBox = New System.Windows.Forms.GroupBox()
        Me.ConnectDisconnectButton = New System.Windows.Forms.Button()
        Me.SerialPortComboBox = New System.Windows.Forms.ComboBox()
        Me.SerialPort = New System.IO.Ports.SerialPort(Me.components)
        Me.SerialPortRefreshTimer = New System.Windows.Forms.Timer(Me.components)
        Me.ReceivedGroupBox = New System.Windows.Forms.GroupBox()
        Me.ReceivedListBox = New System.Windows.Forms.ListBox()
        Me.CommandGroupBox = New System.Windows.Forms.GroupBox()
        Me.HexCommandTextBox = New System.Windows.Forms.TextBox()
        Me.SendHexButton = New System.Windows.Forms.Button()
        Me.ReceivedDataDisplay = New System.Windows.Forms.Timer(Me.components)
        Me.StatusStrip.SuspendLayout()
        Me.SerialSetupGroupBox.SuspendLayout()
        Me.ReceivedGroupBox.SuspendLayout()
        Me.CommandGroupBox.SuspendLayout()
        Me.SuspendLayout()
        '
        'StatusStrip
        '
        Me.StatusStrip.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.SerialComStatusLabel})
        Me.StatusStrip.Location = New System.Drawing.Point(0, 428)
        Me.StatusStrip.Name = "StatusStrip"
        Me.StatusStrip.Size = New System.Drawing.Size(800, 22)
        Me.StatusStrip.TabIndex = 0
        Me.StatusStrip.Text = "StatusStrip1"
        '
        'SerialComStatusLabel
        '
        Me.SerialComStatusLabel.Name = "SerialComStatusLabel"
        Me.SerialComStatusLabel.Size = New System.Drawing.Size(108, 17)
        Me.SerialComStatusLabel.Text = "Disconnected from"
        '
        'SerialSetupGroupBox
        '
        Me.SerialSetupGroupBox.Controls.Add(Me.ConnectDisconnectButton)
        Me.SerialSetupGroupBox.Controls.Add(Me.SerialPortComboBox)
        Me.SerialSetupGroupBox.Location = New System.Drawing.Point(12, 12)
        Me.SerialSetupGroupBox.Name = "SerialSetupGroupBox"
        Me.SerialSetupGroupBox.Size = New System.Drawing.Size(229, 56)
        Me.SerialSetupGroupBox.TabIndex = 1
        Me.SerialSetupGroupBox.TabStop = False
        Me.SerialSetupGroupBox.Text = "COM Port"
        '
        'ConnectDisconnectButton
        '
        Me.ConnectDisconnectButton.Location = New System.Drawing.Point(136, 19)
        Me.ConnectDisconnectButton.Name = "ConnectDisconnectButton"
        Me.ConnectDisconnectButton.Size = New System.Drawing.Size(87, 21)
        Me.ConnectDisconnectButton.TabIndex = 2
        Me.ConnectDisconnectButton.Text = "Connect"
        Me.ConnectDisconnectButton.UseVisualStyleBackColor = True
        '
        'SerialPortComboBox
        '
        Me.SerialPortComboBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.SerialPortComboBox.FormattingEnabled = True
        Me.SerialPortComboBox.Location = New System.Drawing.Point(6, 19)
        Me.SerialPortComboBox.Name = "SerialPortComboBox"
        Me.SerialPortComboBox.Size = New System.Drawing.Size(124, 21)
        Me.SerialPortComboBox.TabIndex = 2
        '
        'SerialPort
        '
        '
        'SerialPortRefreshTimer
        '
        Me.SerialPortRefreshTimer.Interval = 500
        '
        'ReceivedGroupBox
        '
        Me.ReceivedGroupBox.Controls.Add(Me.ReceivedListBox)
        Me.ReceivedGroupBox.Location = New System.Drawing.Point(247, 12)
        Me.ReceivedGroupBox.Name = "ReceivedGroupBox"
        Me.ReceivedGroupBox.Size = New System.Drawing.Size(229, 162)
        Me.ReceivedGroupBox.TabIndex = 2
        Me.ReceivedGroupBox.TabStop = False
        Me.ReceivedGroupBox.Text = "COM Port"
        '
        'ReceivedListBox
        '
        Me.ReceivedListBox.FormattingEnabled = True
        Me.ReceivedListBox.Location = New System.Drawing.Point(6, 19)
        Me.ReceivedListBox.Name = "ReceivedListBox"
        Me.ReceivedListBox.Size = New System.Drawing.Size(217, 134)
        Me.ReceivedListBox.TabIndex = 3
        '
        'CommandGroupBox
        '
        Me.CommandGroupBox.Controls.Add(Me.HexCommandTextBox)
        Me.CommandGroupBox.Controls.Add(Me.SendHexButton)
        Me.CommandGroupBox.Location = New System.Drawing.Point(12, 74)
        Me.CommandGroupBox.Name = "CommandGroupBox"
        Me.CommandGroupBox.Size = New System.Drawing.Size(229, 56)
        Me.CommandGroupBox.TabIndex = 3
        Me.CommandGroupBox.TabStop = False
        Me.CommandGroupBox.Text = "Manual Send Hex"
        '
        'HexCommandTextBox
        '
        Me.HexCommandTextBox.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper
        Me.HexCommandTextBox.Location = New System.Drawing.Point(6, 19)
        Me.HexCommandTextBox.Name = "HexCommandTextBox"
        Me.HexCommandTextBox.Size = New System.Drawing.Size(124, 20)
        Me.HexCommandTextBox.TabIndex = 4
        '
        'SendHexButton
        '
        Me.SendHexButton.Location = New System.Drawing.Point(136, 19)
        Me.SendHexButton.Name = "SendHexButton"
        Me.SendHexButton.Size = New System.Drawing.Size(87, 21)
        Me.SendHexButton.TabIndex = 2
        Me.SendHexButton.Text = "Send"
        Me.SendHexButton.UseVisualStyleBackColor = True
        '
        'ReceivedDataDisplay
        '
        Me.ReceivedDataDisplay.Enabled = True
        Me.ReceivedDataDisplay.Interval = 5
        '
        'VBSerialForm
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(800, 450)
        Me.Controls.Add(Me.CommandGroupBox)
        Me.Controls.Add(Me.ReceivedGroupBox)
        Me.Controls.Add(Me.SerialSetupGroupBox)
        Me.Controls.Add(Me.StatusStrip)
        Me.Name = "VBSerialForm"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "PIC Serial Communications"
        Me.StatusStrip.ResumeLayout(False)
        Me.StatusStrip.PerformLayout()
        Me.SerialSetupGroupBox.ResumeLayout(False)
        Me.ReceivedGroupBox.ResumeLayout(False)
        Me.CommandGroupBox.ResumeLayout(False)
        Me.CommandGroupBox.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents StatusStrip As StatusStrip
    Friend WithEvents SerialComStatusLabel As ToolStripStatusLabel
    Friend WithEvents SerialSetupGroupBox As GroupBox
    Friend WithEvents SerialPortComboBox As ComboBox
    Friend WithEvents SerialPort As IO.Ports.SerialPort
    Friend WithEvents SerialPortRefreshTimer As Timer
    Friend WithEvents ConnectDisconnectButton As Button
    Friend WithEvents ReceivedGroupBox As GroupBox
    Friend WithEvents ReceivedListBox As ListBox
    Friend WithEvents CommandGroupBox As GroupBox
    Friend WithEvents SendHexButton As Button
    Friend WithEvents HexCommandTextBox As TextBox
    Friend WithEvents ReceivedDataDisplay As Timer
End Class
