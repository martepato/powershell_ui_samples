
# http://www.codeproject.com/Articles/4479/A-Simple-Bitmap-Button-Implementation

<#
BitmapButton.cs
#>
# $DebugPreference = 'Continue'

param(
  [switch]$pause
)
Add-Type -TypeDefinition @"
using System;
using System.Drawing;
using System.Windows.Forms;

namespace BitmapButton
{
	public class BitmapButton : Button
	{
		enum btnState
		{
			BUTTON_UP=0,
			BUTTON_DOWN=1,
			BUTTON_FOCUSED=2,
			BUTTON_MOUSE_ENTER=3,
			BUTTON_DISABLED=4,
		}

		btnState imgState=btnState.BUTTON_UP;
		bool mouseEnter=false;

		public BitmapButton()
		{
			// enable double buffering.  Must be done by a derived class
			SetStyle(ControlStyles.UserPaint | ControlStyles.AllPaintingInWmPaint | ControlStyles.DoubleBuffer, true);

			// initialize event handlers
			Paint+=new PaintEventHandler(BitmapButton_Paint);
			MouseDown+=new MouseEventHandler(BitmapButton_MouseDown);
			MouseUp+=new MouseEventHandler(BitmapButton_MouseUp);
			GotFocus+=new EventHandler(BitmapButton_GotFocus);
			LostFocus+=new EventHandler(BitmapButton_LostFocus);
			MouseEnter+=new EventHandler(BitmapButton_MouseEnter);
			MouseLeave+=new EventHandler(BitmapButton_MouseLeave);
			KeyDown+=new KeyEventHandler(BitmapButton_KeyDown);
			KeyUp+=new KeyEventHandler(BitmapButton_KeyUp);
			EnabledChanged+=new EventHandler(BitmapButton_EnabledChanged);
		}

		private void BitmapButton_Paint(object sender, PaintEventArgs e)
		{
			Graphics gr=e.Graphics;
			int indexWidth=Size.Width*(int)imgState;

			if (Image.Width > indexWidth)
			{
				gr.DrawImage(Image, 0, 0, new Rectangle(new Point(indexWidth, 0), Size), GraphicsUnit.Pixel);
			}
			else
			{
				gr.DrawImage(Image, 0, 0, new Rectangle(new Point(0, 0), new Size(Size.Width, Size.Height)), GraphicsUnit.Pixel);
			}
		}

		private void BitmapButton_MouseDown(object sender, MouseEventArgs e)
		{
			imgState=btnState.BUTTON_DOWN;
			Invalidate();
		}

		private void BitmapButton_MouseUp(object sender, MouseEventArgs e)
		{
			imgState=btnState.BUTTON_FOCUSED;
			Invalidate();
		}

		private void BitmapButton_GotFocus(object sender, EventArgs e)
		{
			imgState=btnState.BUTTON_FOCUSED;
			Invalidate();
		}

		private void BitmapButton_LostFocus(object sender, EventArgs e)
		{
			if (mouseEnter)
			{
				imgState=btnState.BUTTON_MOUSE_ENTER;
			}
			else
			{
				imgState=btnState.BUTTON_UP;
			}
			Invalidate();
		}

		private void BitmapButton_MouseEnter(object sender, EventArgs e)
		{
			// only show mouse enter if doesn't have focus
			if (imgState==btnState.BUTTON_UP)
			{
				imgState=btnState.BUTTON_MOUSE_ENTER;
			}
			mouseEnter=true;
			Invalidate();
		}

		private void BitmapButton_MouseLeave(object sender, EventArgs e)
		{
			// only restore state if doesn't have focus
			if (imgState != btnState.BUTTON_FOCUSED)
			{
				imgState=btnState.BUTTON_UP;
			}
			mouseEnter=false;
			Invalidate();
		}

		private void BitmapButton_KeyDown(object sender, KeyEventArgs e)
		{
			if (e.KeyData==Keys.Space)
			{
				imgState=btnState.BUTTON_DOWN;
				Invalidate();
			}
		}

		private void BitmapButton_KeyUp(object sender, KeyEventArgs e)
		{
			if (e.KeyData==Keys.Space)
			{
				// still has focus
				imgState=btnState.BUTTON_FOCUSED;
				Invalidate();
			}
		}

		private void BitmapButton_EnabledChanged(object sender, EventArgs e)
		{
			if (Enabled)
			{
				imgState=btnState.BUTTON_UP;
			}
			else
			{
				imgState=btnState.BUTTON_DISABLED;
			}
			Invalidate();
		}
	}
}
"@ -ReferencedAssemblies 'System.Windows.Forms.dll','System.Drawing.dll','System.Data.dll'


# http://stackoverflow.com/questions/8343767/how-to-get-the-current-directory-of-the-cmdlet-being-executed
function Get-ScriptDirectory
{
  $Invocation = (Get-Variable MyInvocation -Scope 1).Value
  if ($Invocation.PSScriptRoot)
  {
    $Invocation.PSScriptRoot
  }
  elseif ($Invocation.MyCommand.Path)
  {
    Split-Path $Invocation.MyCommand.Path
  }
  else
  {
    $Invocation.InvocationName.Substring(0,$Invocation.InvocationName.LastIndexOf("\"))
  }
}

@( 'System.Drawing','System.Windows.Forms','System.Windows.Forms.VisualStyles') | ForEach-Object { [void][System.Reflection.Assembly]::LoadWithPartialName($_) }
$result = ''

$f = New-Object System.Windows.Forms.Form
$l1 = New-Object System.Windows.Forms.Label

$l1 = New-Object System.Windows.Forms.Label
$l2 = New-Object System.Windows.Forms.Label
$o1 = New-Object -TypeName 'BitmapButton.BitmapButton'

$o1.Location = New-Object System.Drawing.Point (232,32)
$o1.Size = New-Object System.Drawing.Size (32,32)
$o1.Name  = 'b1'
$o1.TabIndex = 1
$o1.Text = "b1"
$o1.Image = New-Object System.Drawing.Bitmap ([System.IO.Path]::Combine((Get-ScriptDirectory),"downArrow.bmp"))


$o2 = New-Object -TypeName 'BitmapButton.BitmapButton'

$o2.Location = New-Object System.Drawing.Point (232,64)
$o2.Size = New-Object System.Drawing.Size (32,32)
$o2.TabIndex = 2
$o1.Name  = 'b2'
$o2.Text = "b2"
$o2.Image = New-Object System.Drawing.Bitmap ([System.IO.Path]::Combine((Get-ScriptDirectory),"downArrow.bmp"))

# may switch to more coarse handlers 
#			$oClick+=new EventHandler(BitmapButton_Click);

$f.SuspendLayout()

# label
$l1.BorderStyle = [System.Windows.Forms.BorderStyle]::None
$l1.Location = New-Object System.Drawing.Point (12,39)
$l1.Name = "l1"
$l1.Size = New-Object System.Drawing.Size (207,23)
$l1.TabIndex = 4

# label
$l2.BorderStyle = [System.Windows.Forms.BorderStyle]::None
$l2.Location = New-Object System.Drawing.Point (12,51)
$l2.Name = "l2"
$l2.Size = New-Object System.Drawing.Size (207,23)
$l2.TabIndex = 4

# dDControls
$o1.Name = "b1"
$o1.TabIndex = 1
$global:m = @{ 'b1' = 'l1';
'b2' = 'l2';
}

function find_label {
param([string]$button_name)
  $local:label_name = $global:m[$button_name] 
   
  if (($local:label_name -eq $null ) -or ($local:label_name -eq  '' ))  { 
   $local:label_name = 'notfound'
  } 
write-host ('Label Name = {0}' -f  $local:label_name )
return $local:label_name

}
$button_OnMouseDown = {
  param(
    [object]$sender,[System.Windows.Forms.MouseEventArgs]$e
  )
  $local:label_name = find_label  -button_name $sender.Text
  try {
    $elems = $sender.Parent.Controls.Find($local:label_name,$false)
  } catch [exception]{
     write-host $_.Exception.Message 
  }
  if ($elems -ne $null) {
    write-host $elems '0:'
    write-host $elems[0]

    write-host $elems ' 1:'
    write-host $elems[1]
    $elems[0].Text = 'Pressed'
  }
}

$o1.add_MouseDown($button_OnMouseDown)
$o2.add_MouseDown($button_OnMouseDown)
$button_OnMouseUp = {
  param(
    [object]$sender,[System.Windows.Forms.MouseEventArgs]$e
  )
  write-host $sender
  write-host  ('sender.Text  = {0} ' -f $sender.Text)
  $local:label_name = find_label  -button_name $sender.Text
  try {
    $elems = $sender.Parent.Controls.Find($local:label_name,$false)
  } catch [exception]{
     write-host $_.Exception.Message 
  }
  if ($elems -ne $null) {
    $elems[0].Text = ''
  }
}

$o1.add_MouseUp($button_OnMouseUp)
$o2.add_MouseUp($button_OnMouseUp)
$button_OnEnabledChanged = {
  param(
    [object]$sender,[System.EventArgs]$e
  )
}

$o1.add_EnabledChanged($button_OnEnabledChanged)
$o2.add_EnabledChanged($button_OnEnabledChanged)

$button_OnKeyDown = {
  param(
    [object]$sender,[System.Windows.Forms.KeyEventArgs]$e
  )
  if ($e.KeyData -eq [System.Windows.Forms.Keys]::Space)
  {
    try {
      $elems = $f.Controls.Find('l1',$false)
    } catch [exception]{
    }
    if ($elems -ne $null) {
      $elems[0].Text = 'Pressed'
    }

  }
}

$o1.add_KeyDown($button_OnKeyDown)
$o2.add_KeyDown($button_OnKeyDown)
$button_OnKeyUp = {
  param(
    [object]$sender,[System.Windows.Forms.KeyEventArgs]$e
  )
  if ($e.KeyData -eq [System.Windows.Forms.Keys]::Space)
  {
    try {
      $elems = $f.Controls.Find('l1',$false)
    } catch [exception]{
    }
    if ($elems -ne $null) {
      $elems[0].Text = ''
    }

  }
}

$o1.add_KeyUp($button_OnKeyUp)

# Form
$f.AutoScaleDimensions = New-Object System.Drawing.SizeF (6.0,13.0)
$f.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::Font
$f.ClientSize = New-Object System.Drawing.Size (263,109)
# $f.Controls.Add($o1, $o2  )

$f.Controls.AddRange(@( $l1,$o1, $o2))
$f.Name = 'form'
$f.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$f.Text = 'Bitmap Button Demo'
$f.ResumeLayout($false)
# TODO: merge with http://www.codeproject.com/Articles/4479/A-Simple-Bitmap-Button-Implementation
# http://www.alkanesolutions.co.uk/2013/04/19/embedding-base64-image-strings-inside-a-powershell-application/
$f.Add_Shown({ $f.Activate() })
[void]$f.ShowDialog()
$o1.Text
Write-Debug $result
