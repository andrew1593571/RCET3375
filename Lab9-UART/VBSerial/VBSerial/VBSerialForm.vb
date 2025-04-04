﻿Option Explicit On
Option Strict On
Option Compare Text

Public Class VBSerialForm
    Private receivedData As New Queue(Of Byte)

    Sub ControlPIC(servoPosition As Integer)
        Dim controlbytes(2) As Byte
        controlbytes(0) = &H24
        controlbytes(2) = &H51 'special command byte for requesting ADC values

        Select Case servoPosition
            Case > 255
                controlbytes(1) = CByte(255)
            Case < 0
                controlbytes(1) = CByte(0)
            Case Else
                controlbytes(1) = CByte(servoPosition)
        End Select

        'If the serial port is open, command the servo
        If SerialPort.IsOpen Then
            SerialPort.Write(controlbytes, 0, 3)
        End If

    End Sub

    ''' <summary>
    ''' Initialize the form. Starts the available serial port name refresh timer.
    ''' Sets the SerialComStatusLabel to disconnected from current port.
    ''' sets the serial port up for 9600 baud, 8bit data, one stop bit, and no parity bit
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    Private Sub VBSerialForm_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        AvailableCOMRefreshTimer.Start()
        SerialComStatusLabel.Text = $"Disconnected from {SerialPort.PortName}"
        SerialPort.BaudRate = 9600
        SerialPort.DataBits = 8
        SerialPort.StopBits = IO.Ports.StopBits.One
        SerialPort.Parity = IO.Ports.Parity.None
    End Sub

    Private Sub AvailableCOMRefreshTimer_Tick(sender As Object, e As EventArgs) Handles AvailableCOMRefreshTimer.Tick
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
                ControlPIC(ServoTrackBar.Value)
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
                message &= Convert.ToString(byteArray(i), 2) & vbNewLine
            Next
            If SerialPort.IsOpen Then
                SerialPort.Write(byteArray, 0, byteArray.Length)
            Else
                MsgBox("Unable to send command. Please Connect to COM device.")
            End If
            'MsgBox(message)
            'MsgBox(Convert.ToInt32(HexCommandTextBox.Text, 16))
            'MsgBox(CByte(Convert.ToInt32(HexCommandTextBox.Text, 16)))
        End If
    End Sub

    Private Sub SerialPort_DataReceived(sender As Object, e As IO.Ports.SerialDataReceivedEventArgs) Handles SerialPort.DataReceived
        Dim numberofBytes = SerialPort.BytesToRead
        Dim bytes(numberofBytes - 1) As Byte

        SerialPort.Read(bytes, 0, numberofBytes)
        For i = 0 To bytes.Length - 1
            Me.receivedData.Enqueue(bytes(i))

        Next

    End Sub

    Private Sub SerialDataUpdateTimer_Tick(sender As Object, e As EventArgs) Handles SerialDataUpdateTimer.Tick
        Dim receivedByte As Byte
        Dim analogMSB As Byte
        Dim analogLSB As Byte
        Dim analogValue As Integer
        Dim analogVoltage As Double
        Dim analogTemperature As Double

        'Add received data to the listbox
        If receivedData.Count <> 0 Then
            For i = 0 To receivedData.Count - 1
                receivedByte = receivedData.Dequeue

                If receivedByte = &H24 Then
                    'PIC packet start byte received, handle data received
                    Try
                        analogMSB = receivedData.Dequeue
                        analogLSB = receivedData.Dequeue
                        i += 2
                        ReceivedListBox.Items.Add($"{Hex(receivedByte)} {Hex(analogMSB)} {Hex(analogLSB)}")
                    Catch ex As Exception
                        Exit Sub
                    End Try
                Else
                    'if did not receive PIC start byte, add to listbox as single byte
                    ReceivedListBox.Items.Add(Hex(receivedByte))
                End If

                If ReceivedListBox.Items.Count > 10 Then
                    ReceivedListBox.Items.RemoveAt(0)
                End If

            Next
            ReceivedListBox.SelectedIndex = ReceivedListBox.Items.Count - 1
        End If

        'update the analog values
        analogValue = (CInt(analogMSB) * 256) + CInt(analogLSB)
        analogVoltage = analogValue * (5 / 1023)
        analogTemperature = analogVoltage / 0.01
        AnalogLabel.Text = CStr(analogValue)
        AnalogVoltageLabel.Text = $"{analogVoltage.ToString("0.000")} Volts"
        TemperatureLabel.Text = $"{analogTemperature.ToString("0.000")} °F"

        'call the ControlPIC sub to update the servo value and request updated analog
        ControlPIC(ServoTrackBar.Value)
    End Sub

    Private Sub ServoTrackBar_Scroll(sender As Object, e As EventArgs) Handles ServoTrackBar.Scroll
        ServoPositionLabel.Text = CStr(ServoTrackBar.Value)
    End Sub
End Class
