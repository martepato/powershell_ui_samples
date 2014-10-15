#Copyright (c) 2014 Serguei Kouzmine
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in
#all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#THE SOFTWARE.

Add-Type -TypeDefinition @"

// "
// http://www.codeproject.com/Tips/827370/Custom-Message-Box-DLL

using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using System.Drawing;
// using System.Drawing.Design;
using System.Drawing.Imaging;
using System.ComponentModel;
using System.Reflection;
using System.Linq;


namespace nameMSGBOX
{
public enum MSGICON
    {
        Error,
        Information,
        Warning,
        Question,
    }
public enum MSGBUTTON
    {
        None,
        OK,
        YesNo,
        YesNoCancel,
        RetryCancle,
        AbortRetryIgnore
    }
public enum MSGRESPONSE
    {
        None,
        Yes,
        No,
        OK,
        Abort,
        Retry,
        Ignore,
        Cancel
    }
    public class MSGBOX
    {
     public Form frm = new Form();
     internal Button btnDetails = new Button();
     Button btnOK = new Button();
     Button btnYes = new Button();
     Button btnNo = new Button();
     Button btnCancel = new Button();
     Button btnAbort = new Button();
     Button btnRetry = new Button();
     Button btnIgnore = new Button();
     TextBox txtDescription = new TextBox();
     PictureBox icnPicture = new PictureBox();
     Panel formpanel = new Panel();
     Label lblmessage = new Label();
     static MSGRESPONSE msgresponse = new MSGRESPONSE();

     public void DrawBox()
        {
            //draw panel
            frm.Controls.Add(formpanel);
            formpanel.Dock = DockStyle.Fill;
            //draw picturebox
            icnPicture.Height = 36;
            icnPicture.Width = 40;
            icnPicture.Location = new Point(10, 11);
            formpanel.Controls.Add(icnPicture);
          //drawing textbox
            txtDescription.Multiline = true;
            txtDescription.Height = 183;
            txtDescription.Width = 464;
            txtDescription.Location = new Point(6, 143);
            txtDescription.BorderStyle = BorderStyle.Fixed3D;
            txtDescription.ScrollBars = ScrollBars.Both;
            txtDescription.ReadOnly = true;
            formpanel.Controls.Add(txtDescription);

        //drawing detail button
            btnDetails.Height = 24;
            btnDetails.Width = 80;
            btnDetails.Location = new Point(6, 114);
            btnDetails.Tag = "exp";
            btnDetails.Text = "Show Details";
            formpanel.Controls.Add(btnDetails);
            this.btnDetails.Click += new EventHandler(this.btnDetails_click);
            lblmessage.Location = new Point(64, 22);
            lblmessage.AutoSize = true;
            formpanel.Controls.Add(lblmessage);
            frm.Height = 360;
            frm.Width = 483;

            //set form layout
            frm.StartPosition = FormStartPosition.CenterScreen;
            frm.FormBorderStyle = FormBorderStyle.FixedSingle;
            frm.MaximizeBox = false;
            frm.MinimizeBox = false;
            frm.FormClosing += new FormClosingEventHandler(frm_FormClosing);
            frm.BackColor = System.Drawing.SystemColors.ButtonFace;

            //http://www.iconarchive.com/search?q=ico+files&page=7
            string p = @"C:\developer\sergueik\powershell_ui_samples\external\Martz90-Circle-Files.ico";
            frm.Icon = new System.Drawing.Icon( p );
            if (btnDetails.Tag.ToString() == "exp")
            {
                frm.Height = frm.Height - txtDescription.Height - 6;
                btnDetails.Tag = "col";
                btnDetails.Text = "Show Details";
            }
        }

         public void AddButton(MSGBUTTON MSGBTN)
        {
            switch (MSGBTN)
            {
               case MSGBUTTON.OK:
                    {
                        btnOK.Width = 80;
                        btnOK.Height = 24;
                        btnOK.Location = new Point(391, 114);
                        btnOK.Text = "OK";
                        formpanel.Controls.Add(btnOK);
                        btnOK.Click += new EventHandler(Return_Response);
                    }
                    break;
               
                case MSGBUTTON.YesNo:
                    {
                        //btnNo
                        btnNo.Width = 80;
                        btnNo.Height = 24;
                        btnNo.Location = new Point(391, 114);
                        btnNo.Text = "No";
                        formpanel.Controls.Add(btnNo);
                        btnNo.Click += new EventHandler(Return_Response);
                        //btnYes
                        btnYes.Width = 80;
                        btnYes.Height = 24;
                        btnYes.Location = new Point(btnNo.Location.X - btnNo.Width - 2, 114);
                        btnYes.Text = "Yes";
                        formpanel.Controls.Add(btnYes);
                        btnYes.Click += new EventHandler(Return_Response);
                    }
                    break;
              
               case MSGBUTTON.YesNoCancel:
                    {
                        //btnCancle
                        btnCancel.Width = 80;
                        btnCancel.Height = 24;
                        btnCancel.Location = new Point(391, 114);
                        btnCancel.Text = "Cancel";
                        formpanel.Controls.Add(btnCancel);
                        btnCancel.Click += new EventHandler(Return_Response);
                        //btnNo
                        btnNo.Width = 80;
                        btnNo.Height = 24;
                        btnNo.Location = new Point(btnCancel.Location.X - btnCancel.Width - 2, 114);
                        btnNo.Text = "No";
                        formpanel.Controls.Add(btnNo);
                        btnNo.Click += new EventHandler(Return_Response);
                        //btnYes
                        btnYes.Width = 80;
                        btnYes.Height = 24;
                        btnYes.Location = new Point(btnNo.Location.X - btnNo.Width - 2, 114);
                        btnYes.Text = "Yes";
                        formpanel.Controls.Add(btnYes);
                        btnYes.Click += new EventHandler(Return_Response);
                    }
                    break;

                  case MSGBUTTON.RetryCancle:
                    {
                        //button cancel
                        btnCancel.Width = 80;
                        btnCancel.Height = 24;
                        btnCancel.Location = new Point(391, 114);
                        btnCancel.Text = "Cancel";
                        formpanel.Controls.Add(btnCancel);
                        btnCancel.Click += new EventHandler(Return_Response);
                        //button Retry
                        btnRetry.Width = 80;
                        btnRetry.Height = 24;
                        btnRetry.Location = new Point(btnCancel.Location.X - btnCancel.Width - 2, 114);
                        btnRetry.Text = "Retry";
                        formpanel.Controls.Add(btnRetry);
                        btnRetry.Click += new EventHandler(Return_Response);
                    }
                    break;

                    case MSGBUTTON.AbortRetryIgnore:
                    {
                        //button Ignore
                        btnIgnore.Width = 80;
                        btnIgnore.Height = 24;
                        btnIgnore.Location = new Point(391, 114);
                        btnIgnore.Text = "Ignore";
                        formpanel.Controls.Add(btnIgnore);
                        btnIgnore.Click += new EventHandler(Return_Response);
                        //button Retry
                        btnRetry.Width = 80;
                        btnRetry.Height = 24;
                        btnRetry.Location = new Point(btnIgnore.Location.X - btnIgnore.Width - 2, 114);
                        btnRetry.Text = "Retry";
                        formpanel.Controls.Add(btnRetry);
                        btnRetry.Click += new EventHandler(Return_Response);
                        //button Abort
                        btnAbort.Width = 80;
                        btnAbort.Height = 24;
                        btnAbort.Location = new Point(btnRetry.Location.X - btnRetry.Width - 2, 114);
                        btnAbort.Text = "Abort";
                        formpanel.Controls.Add(btnAbort);
                        btnAbort.Click += new EventHandler(Return_Response);
                    }
                    break;

                   case MSGBUTTON.None:
                    {
                        btnOK.Width = 80;
                        btnOK.Height = 24;
                        btnOK.Location = new Point(391, 114);
                        btnOK.Text = "OK";
                        formpanel.Controls.Add(btnOK);
                        btnOK.Click += new EventHandler(Return_Response);
                    }
                    break;
            }
        }

        public void AddIconImage(MSGICON MSGICON)
        {
            switch (MSGICON)
            {
                case MSGICON.Error:
                    icnPicture.Image = SystemIcons.Error.ToBitmap();  //Error is key name in 
                            //imagelist control which uniqly identified images in ImageList control.
                    break;
                case MSGICON.Information:
                    icnPicture.Image = SystemIcons.Information.ToBitmap();
                    break;
                case MSGICON.Question:
                    icnPicture.Image = SystemIcons.Question.ToBitmap();
                    break;
                case MSGICON.Warning:
                    icnPicture.Image = SystemIcons.Warning.ToBitmap();
                    break;
                default:
                    icnPicture.Image = SystemIcons.Information.ToBitmap();
                    break;
            }
        }

        private void btnDetails_click(object sender, EventArgs e)
        {
            if (btnDetails.Tag.ToString() == "col")
            {
                frm.Height = frm.Height + txtDescription.Height + 6;
                btnDetails.Tag = "exp";
                btnDetails.Text = "Hide Details";
                txtDescription.WordWrap = true;
                //txtDescription.Focus();
                //txtDescription.SelectionLength = 0;
            }
            else if (btnDetails.Tag.ToString() == "exp")
            {
                frm.Height = frm.Height - txtDescription.Height - 6;
                btnDetails.Tag = "col";
                btnDetails.Text = "Show Details";
            }
        }

        private void frm_FormClosing(object sender, EventArgs e)
        {
            if (msgresponse == MSGRESPONSE.None)
            {
                msgresponse = MSGRESPONSE.Cancel;
            }
        }

         private void Return_Response(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string buttonText = btn.Text;
            if (buttonText == "Yes")
            {
                msgresponse = MSGRESPONSE.Yes;
            }
            else if (buttonText == "No")
            {
                msgresponse = MSGRESPONSE.No;
            }
            else if (buttonText == "Cancel")
            {
                msgresponse = MSGRESPONSE.Cancel;
            }
           else if (buttonText == "OK")
            {
                msgresponse = MSGRESPONSE.OK;
            }
          else if (buttonText == "Abort")
            {
                msgresponse = MSGRESPONSE.Abort;
            }
         else if (buttonText == "Retry")
            {
                msgresponse = MSGRESPONSE.Retry;
            }
         else if (buttonText == "Ignore")
            {
                msgresponse = MSGRESPONSE.Ignore;
            }
         else
            {
                msgresponse = MSGRESPONSE.Cancel;
            }
         frm.Dispose();
        }

 public static MSGRESPONSE Show(string messageText)
        {
            MSGBOX frmMessage = new MSGBOX();
            frmMessage.SetMessageText(messageText, "", null);
            frmMessage.AddIconImage(MSGICON.Information);
            frmMessage.AddButton(MSGBUTTON.OK);
            frmMessage.DrawBox();
            frmMessage.frm.ShowDialog();
            return msgresponse;
        }
    public static MSGRESPONSE Show(string messageText, string messageTitle, string description)
        {
            MSGBOX frmMessage = new MSGBOX();
            frmMessage.SetMessageText(messageText, messageTitle, description);
            frmMessage.AddIconImage(MSGICON.Information);
            frmMessage.AddButton(MSGBUTTON.OK);
            frmMessage.DrawBox();
            frmMessage.frm.ShowDialog();
            return msgresponse;
        }

      public static MSGRESPONSE Show(string messageText, 
          string messageTitle, string description, MSGICON IcOn, MSGBUTTON btn)
        {
            MSGBOX frmMessage = new MSGBOX();
            frmMessage.SetMessageText(messageText, messageTitle, description);
            //frmMessage.Text = messageTitle;
            frmMessage.AddIconImage(IcOn);
            frmMessage.AddButton(btn);
            frmMessage.DrawBox();
            frmMessage.frm.ShowDialog();
            return msgresponse;
        }

         public static MSGRESPONSE ShowException(Exception ex)
        {
            MSGBOX frmMessage = new MSGBOX();
            frmMessage.SetMessageText(ex.Message, ex.Message, ex.StackTrace);
            //frmMessage.Text = messageTitle;
            frmMessage.AddIconImage(MSGICON.Error);
            frmMessage.AddButton(MSGBUTTON.OK);
            frmMessage.DrawBox();
            frmMessage.frm.ShowDialog();
            return msgresponse;
        }

        public void SetMessageText(string messageText, string Title, string Description)
        {
            this.lblmessage.Text = messageText;
            if (!string.IsNullOrEmpty(Description))
            {
                this.txtDescription.Text = Description;
            }
            else
            {
                btnDetails.Visible = false;
            }
            if (!string.IsNullOrEmpty(Title))
            {
                frm.Text = Title;
            }
            else
            {
                frm.Text = "Your Message Box From DLL";
            }
        }
    }
}

"@ -ReferencedAssemblies 'System.Windows.Forms.dll','System.Drawing.dll','System.Data.dll','System.ComponentModel.dll'


# $o = New-Object -Type 'nameMSGBOX.MSGBOX'
# $o.SetMessageText("Test","this is a Lorem Ipsum test","This is is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.")
# $o.AddIconImage([nameMSGBOX.MSGICON]::Information)
# $o.AddButton([nameMSGBOX.MSGBUTTON]::OK)
# $o.DrawBox()
# $o.frm.ShowDialog()

$MSGICON = @{

'None' =  0;
'Error' =  10;
'Information' =  20;
'Warning' =  30;
'Question' =  40;

}
<#
$MSGICON = New-Object PSObject
$MSGICON | Add-Member -NotePropertyName 'None' -NotePropertyValue 0
$MSGICON | Add-Member -NotePropertyName 'Error' -NotePropertyValue 10
$MSGICON | Add-Member -NotePropertyName 'Information' -NotePropertyValue 20
$MSGICON | Add-Member -NotePropertyName 'Warning' -NotePropertyValue 30
$MSGICON | Add-Member -NotePropertyName 'Question' -NotePropertyValue 40
#>

$MSGBUTTON = New-Object PSObject
$MSGBUTTON | Add-Member -NotePropertyName 'None' -NotePropertyValue 0
$MSGBUTTON | Add-Member -NotePropertyName 'OK' -NotePropertyValue 1
$MSGBUTTON | Add-Member -NotePropertyName 'YesNo' -NotePropertyValue 2
$MSGBUTTON | Add-Member -NotePropertyName 'YesNoCancel' -NotePropertyValue 3
$MSGBUTTON | Add-Member -NotePropertyName 'RetryCancle' -NotePropertyValue 4
$MSGBUTTON | Add-Member -NotePropertyName 'AbortRetryIgnore' -NotePropertyValue 5

$MSGRESPONSE = New-Object PSObject
$MSGRESPONSE | Add-Member -NotePropertyName 'None' -NotePropertyValue 0
$MSGRESPONSE | Add-Member -NotePropertyName 'Yes' -NotePropertyValue 1
$MSGRESPONSE | Add-Member -NotePropertyName 'No' -NotePropertyValue 2
$MSGRESPONSE | Add-Member -NotePropertyName 'OK' -NotePropertyValue 3
$MSGRESPONSE | Add-Member -NotePropertyName 'Abort' -NotePropertyValue 4
$MSGRESPONSE | Add-Member -NotePropertyName 'Retry' -NotePropertyValue 5
$MSGRESPONSE | Add-Member -NotePropertyName 'Ignore' -NotePropertyValue 6
$MSGRESPONSE | Add-Member -NotePropertyName 'Cancel' -NotePropertyValue 7

function AddButton {
  # 
  # AddButton -MSGBTN $MSGBUTTON.YesNoCancel
  param([psobject]$param)

  switch ($param) {
    ($MSGBUTTON.None) {
      $btnOK.Width = 80
      $btnOK.Height = 24
      $btnOK.Location = New-Object System.Drawing.Point (391,114)
      $btnOK.Text = "OK"
      $formpanel.Controls.Add($btnOK)
      # $btnOK.Click += new EventHandler(Return_Response)
    }
    ($MSGBUTTON.OK) {}
    ($MSGBUTTON.YesNo) {}
    ($MSGBUTTON.YesNoCancel) {}
    ($MSGBUTTON.RetryCancle) {}
    ($MSGBUTTON.AbortRetryIgnore) {}
    default {}
  }

}


function AddIconImage {
  param([psobject]$param)

  switch ($param)
  {
    ($MSGICON.Error) {
      #  icnPicture.Image = SystemIcons.Error.ToBitmap();  
    }
    ($MSGICON.Information) {

      # icnPicture.Image = SystemIcons.Information.ToBitmap();
    }
    ($MSGICON.Question) {
      # icnPicture.Image = SystemIcons.Question.ToBitmap();
    }
    ($MSGICON.Warning) {
      # icnPicture.Image = SystemIcons.Warning.ToBitmap();
    }
    default {
      # icnPicture.Image = SystemIcons.Information.ToBitmap();
    }
  }

}


function MSGBOX
{

  [void][System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
  [void][System.Reflection.Assembly]::LoadWithPartialName('System.Drawing')

  $frm = New-Object System.Windows.Forms.Form
  $btnDetails = New-Object System.Windows.Forms.Button
  $btnOK = New-Object System.Windows.Forms.Button
  $btnYes = New-Object System.Windows.Forms.Button
  $btnNo = New-Object System.Windows.Forms.Button
  $btnCancel = New-Object System.Windows.Forms.Button
  $btnAbort = New-Object System.Windows.Forms.Button
  $btnRetry = New-Object System.Windows.Forms.Button
  $btnIgnore = New-Object System.Windows.Forms.Button
  $txtDescription = New-Object System.Windows.Form.TextBox
  $icnPicture = New-Object System.Windows.FormPictureBox
  $formpanel = New-Object System.Windows.Form.Panel
  $lblmessage = New-Object System.Windows.Form.Label
  # static MSGRESPONSE msgresponse = new MSGRESPONSE();
}

function btnDetails_click
        {

param([object] $sender, [System.EventArgs]$eventArgs )
            if ($btnDetails.Tag.ToString() -match "col")
            {
                $frm.Height = frm.Height + $txtDescription.Height + 6 
                $btnDetails.Tag = "exp" 
                $btnDetails.Text = "Hide Details"
                $txtDescription.WordWrap = true 
                # txtDescription.Focus();
                # txtDescription.SelectionLength = 0;
            }
            elseif ($btnDetails.Tag.ToString() -match "exp")
            {
                $frm.Height = $frm.Height - $txtDescription.Height - 6
                $btnDetails.Tag = "col"
                $btnDetails.Text = "Show Details"
            }
        }
function  SetMessageText
        {
param (
[string] $messageText, 
[string] $Title, 
[string] $Description
)
            $lblmessage.Text = messageText
            if (($Description -ne $null ) -and ($Description -ne ''))
            {
                $txtDescription.Text = $Description
            }
            else
            {
                $btnDetails.Visible = $false
            }
            if (($Title -ne $null ) -and ($Title-ne ''))
            {
                $frm.Text = $Title
            }
            else
            {
                $frm.Text = "Your Message Box From DLL"
            }
        }

AddIconImage -param $MSGICON.Information

# $o = New-Object -Type 'nameMSGBOX.MSGBOX'
# $o.SetMessageText("Test","this is a Lorem Ipsum test","This is is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.")
# $o.AddIconImage([nameMSGBOX.MSGICON]::Information)
# $o.AddButton([nameMSGBOX.MSGBUTTON]::OK)
# $o.DrawBox()
# $o.frm.ShowDialog()


