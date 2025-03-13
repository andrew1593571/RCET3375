Option Explicit On
Option Strict On
Option Compare Text

Public Class VBSerialForm
    ''' <summary>
    ''' Initialize the form. Starts the available serial port name refresh timer.
    ''' Sets the SerialComStatusLabel to disconnected from current port.
    ''' sets the serial port up for 9600 baud, 8bit data, one stop bit, and no parity bit
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    Private Sub VBSerialForm_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        SerialPortRefreshTimer.Start()
        SerialComStatusLabel.Text = $"Disconnected from {SerialPort.PortName}"
        SerialPort.BaudRate = 9600
        SerialPort.DataBits = 8
        SerialPort.StopBits = IO.Ports.StopBits.One
        SerialPort.Parity = IO.Ports.Parity.None
    End Sub

    Private Sub SerialPortRefreshTimer_Tick(sender As Object, e As EventArgs) Handles SerialPortRefreshTimer.Tick
        If Not SerialPort.IsOpen And Not SerialPortComboBox.DroppedDown Then
            SerialPortComboBox.Items.Clear()
            For Each sp As String In My.Computer.Ports.SerialPortNames
                SerialPortComboBox.Items.Add(sp)
            Next
            SerialPortComboBox.Text = SerialPort.PortName
        End If
    End Sub

    Private Sub ConnectDisconnectButton_Click(sender As Object, e As EventArgs) Handles ConnectDisconnectButton.Click
        If SerialPort.IsOpen Then
            SerialPort.Close()
            ConnectDisconnectButton.Text = "Connect"
            SerialComStatusLabel.Text = $"Disconnected from {SerialPort.PortName}"
        Else
            Try
                SerialPort.Open()
                ConnectDisconnectButton.Text = "Disconnect"
                SerialComStatusLabel.Text = $"Connected to {SerialPort.PortName}"
            Catch ex As Exception
                MsgBox($"Failed to connect on {SerialPort.PortName}.{vbNewLine}{vbNewLine}Please select a valid COM port.")
            End Try
        End If
    End Sub

    ''' <summary>
    ''' Occurs when the SerialPortComboBox value is changed. 
    ''' 
    ''' If the serial port is not open, the serial port will be set to the selected value.
    ''' If the serial port is open and the new value is not the connected port, change the value back and prompt the user.
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    Private Sub SerialPortComboBox_SelectedValueChanged(sender As Object, e As EventArgs) Handles SerialPortComboBox.SelectedValueChanged
        If SerialPort.IsOpen Then
            If Not SerialPortComboBox.Text = SerialPort.PortName Then 'If the port is open and the serial port name does not match the connected
                SerialPortComboBox.Text = SerialPort.PortName
                MsgBox("Please disconnect before changing COM port.")
            End If
        Else 'if the port is closed
            SerialPort.PortName = SerialPortComboBox.Text
            SerialComStatusLabel.Text = $"Disconnected from {SerialPort.PortName}"
        End If
    End Sub

    Private Sub HexCommandTextBox_TextChanged(sender As Object, e As EventArgs) Handles HexCommandTextBox.TextChanged
        Dim hexInput As String
        Dim formattedOutput As String = ""

        hexInput = HexCommandTextBox.Text.Replace(" ", "")
        If Not hexInput = "" Then
            If Not "ABCDEF0123456789".Contains(hexInput.Last) Then
                MsgBox($"{hexInput.Last} is not used in Hex. Please enter a Hex value.")
                hexInput = hexInput.Substring(0, hexInput.Length - 1)
            End If

            'format the output to have spaces every two characters
            For i = 0 To hexInput.Length - 1
                formattedOutput &= hexInput(i)
                'add a space after every two characters
                If (i + 1) Mod 2 = 0 AndAlso i < hexInput.Length - 1 Then
                    formattedOutput &= " "
                End If
            Next
            HexCommandTextBox.Text = formattedOutput
            HexCommandTextBox.Select(formattedOutput.Length, 0) 'move cursor back to end of input string
        End If

    End Sub

    Private Sub SendHexButton_Click(sender As Object, e As EventArgs) Handles SendHexButton.Click
        Dim hexArray() As String
        hexArray = HexCommandTextBox.Text.Split(" "c)

        Dim byteArray(hexArray.Length - 1) As Byte

        Dim message As String = ""
        If HexCommandTextBox.Text = "" Then
            MsgBox("Please enter a Hex command.")
        ElseIf HexCommandTextBox.Text.Replace(" ", "").Length Mod 2 <> 0 Then
            MsgBox("There must be an even number of characters.")
        Else
            For i = 0 To hexArray.Length - 1
                byteArray(i) = CByte(Convert.ToInt32(hexArray(i), 16))
                message &= byteArray(i) & vbNewLine
            Next
            MsgBox(message)
            'MsgBox(Convert.ToInt32(HexCommandTextBox.Text, 16))
            'MsgBox(CByte(Convert.ToInt32(HexCommandTextBox.Text, 16)))
        End If
    End Sub
End Class
