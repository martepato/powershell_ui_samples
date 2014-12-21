# http://www.codeproject.com/Articles/23938/Graph-Library
Add-Type @"

// "
 #region PROGRAM HEADER
/*
*********************************************************************************************
* FILE NAME      : DrawGraph.cs                                                             *
* DESCRIPTION    : Generates Bar, Line & Pie graph for a set of values [maximum limit= 10]  *
* AUTHOR         : Anoop Unnikrishnan   (AUK)                                               *
* Licence        : CPOL                                                                     *
* CONTACT        : anoopukrish@gmail.com                                                    *
* NOTE           : Permission given to use and modify this script in ANY kind of            *
*                  applications if header lines are left unchanged.                         *
*********************************************************************************************
* DATE       WHO    VERSION                                                                 *
*-------------------------------------------------------------------------------------------*
* 01/02/2008 AUK    1.0                                                                     *
*********************************************************************************************
 */
 #endregion

using System;
using System.Collections.Generic;
using System.Text;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.Drawing;

namespace System.Anoop.Graph
{

    public class DrawGraph
    {
        string[] valueLabels;
        float[] values;
        string      xLabel;     // Label displayed on x axis
        string      yLabel;     // Label displayed on y axis
        string      fontFormat; // format for labels
        int         alpha;      // alpha for graph
        List<Color> colorList;  // Dark colors only


        // Constructor used for bar graph
        public DrawGraph(string[] valueLabels,float[] values,string xLabel,string yLabel,string fontFormat,int alpha)
        {
            this.valueLabels = valueLabels;
            this.values = values;
            this.xLabel = xLabel;
            this.yLabel = yLabel;
            this.alpha = alpha;
            this.fontFormat=fontFormat;

            InitColorList();
        }

        // Initiatialize color list with dark color's
        private void InitColorList()
        {
            colorList = new List<Color>();

            foreach (string colorName in Enum.GetNames(typeof(System.Drawing.KnownColor)))
            {
                //Check if color is dark
                if (colorName.StartsWith("D") == true)
                {
                    colorList.Add(System.Drawing.Color.FromName(colorName));
                }
            }
        }
         
        //Embed axis for bar graphs
        Bitmap EmbedAxis(Bitmap graph,bool showAxis)
        {
            Bitmap backgroundCanvas = new Bitmap(400, 300);
            Bitmap yLabelImage = new Bitmap(15, 200);
           
            Graphics graphicsBackImage = Graphics.FromImage(backgroundCanvas);
            Graphics objGraphic2 = Graphics.FromImage(graph);
            Graphics objGraphicY = Graphics.FromImage(yLabelImage);

            Pen blackPen = new Pen(Color.Black, 2);

            //Paint the graph canvas white
            SolidBrush whiteBrush = new SolidBrush(Color.White);
            graphicsBackImage.FillRectangle(whiteBrush, 0, 0, 400, 300);

            if (showAxis == true)
            {
                //draw lable for y axis

                StringFormat sf = new StringFormat(StringFormatFlags.DirectionVertical);
                Font f = new Font(fontFormat, 8);
                SizeF sizef = objGraphicY.MeasureString("<- " + yLabel, f, Int32.MaxValue, sf);

                RectangleF rf = new RectangleF(0, 0, sizef.Width, sizef.Height);
                objGraphicY.DrawRectangle(Pens.Transparent, rf.Left, rf.Top, rf.Width, rf.Height);
                objGraphicY.DrawString((yLabel.Length>0?"<- ":"") + yLabel, f, Brushes.Black, rf, sf);
                graphicsBackImage.DrawString(xLabel + (xLabel.Length>0?" ->":""), f, Brushes.Black, 30, 235);
                graphicsBackImage.DrawLine(blackPen, new Point(0, 230), new Point(230, 230));
                graphicsBackImage.DrawLine(blackPen, new Point(20, 20), new Point(20, 250));
            }
            graphicsBackImage.DrawImage(graph, 25, 25);
            if (showAxis == true)
            {
                graphicsBackImage.DrawImage(yLabelImage, 0, 90);
            }
                        
            return (backgroundCanvas);
        }

        //Embed x Panel
        Bitmap EmbedXPanel(Bitmap graph)
        {
            
            Bitmap xPanel = new Bitmap(100, 200);
            Graphics objGraphicPanel = Graphics.FromImage(xPanel);
            Graphics graphicGraph = Graphics.FromImage(graph);
            
            for (int i = 0, x = 10; i < values.Length; i++)
            {
                
                //Draw the bar
                SolidBrush brush = new SolidBrush(Color.FromArgb(alpha,colorList[i]));
                 objGraphicPanel.FillRectangle(brush, 10, 190 - x, 10, 10);

                 string drawString = valueLabels[i] + " = " + values[i].ToString();
                Font drawFont = new Font(fontFormat, 8);
                SolidBrush drawBrush = new SolidBrush(Color.Black);

                 objGraphicPanel.DrawString(drawString, drawFont, drawBrush, 20, 190 - x);

                //x axis spacing by 20
                x += 20;
            }

            graphicGraph.DrawImage(xPanel, 300, 25);
            return (graph);

        }

        //Embed x Panel [Line graph style]
        Bitmap EmbedXLinePanel(Bitmap graph)
        {

            Bitmap xPanel = new Bitmap(100, 200);
            Graphics objGraphicPanel = Graphics.FromImage(xPanel);
            Graphics graphicGraph = Graphics.FromImage(graph);

            for (int i = 1, x = 10; i < values.Length; i++)
            {

                //Draw the bar
                SolidBrush brush = new SolidBrush(Color.FromArgb(alpha, colorList[i]));
                Pen colorPen = new Pen(brush,2);
                objGraphicPanel.DrawLine(colorPen, 10, 190 - x, 20, 190 - x);

                string drawString = valueLabels[i - 1].ToString() + " - " + valueLabels[i].ToString();
                Font drawFont = new Font(fontFormat, 8);
                SolidBrush drawBrush = new SolidBrush(Color.Black);

                objGraphicPanel.DrawString(drawString, drawFont, drawBrush, 20, 190 - x);

                //x axis spacing by 20
                x += 20;
            }

            graphicGraph.DrawImage(xPanel,20,185);
            return (graph);

        }

        //Embed horizontal x Panel [Line graph style]
        Bitmap EmbedHoriXLinePanel(Bitmap graph,string[] newXValues)
        {

            Bitmap xPanel = new Bitmap(400, 100);
            Graphics objGraphicPanel = Graphics.FromImage(xPanel);
            Font drawFont = new Font(fontFormat, 8);
            Graphics graphicGraph = Graphics.FromImage(graph);
            objGraphicPanel.DrawString("Line Graph Color Code", drawFont,Brushes.SlateGray, 0, 0);
            for (int i = 1, x = 0; i < values.Length; i++)
            {

                //Draw the bar
                SolidBrush brush = new SolidBrush(Color.FromArgb(alpha, colorList[i+3]));
               // Pen colorPen = new Pen(brush, 2);
                //objGraphicPanel.DrawLine(colorPen, 10+x, 0, 20+x, 0);

                string drawString = newXValues[i - 1] + " - " + newXValues[i];
               
              //  SolidBrush drawBrush = new SolidBrush(Color.Black);

                objGraphicPanel.DrawString(drawString, drawFont, brush, x, 12);

                //x axis spacing by 20
                x += 70;
            }

            graphicGraph.DrawImage(xPanel,5, 270);
            return (graph);

        }


        //Generate Bar graph
        public Bitmap DrawBarGraph()
        {

            Bitmap objgraph = new Bitmap(200, 200); // Canvas for graph
           
            Graphics graphicGraph = Graphics.FromImage(objgraph);
           
            //Paint the graph canvas white
           // SolidBrush whiteBrush = new SolidBrush(Color.White);
           // graphicGraph.FillRectangle(whiteBrush, 0, 0, 200, 200);


            float highestValue; //Highest value in the values array

            //Get the highest value 
            float[] tempValue = new float[values.Length];
            for (int j = 0; j < values.Length; j++)
            {
                tempValue[j] = values[j];
            }
            Array.Sort<float>(tempValue);
            highestValue = tempValue[values.Length - 1];

            //Generate bar for each value
            for (int i = 0, x = 10; i < values.Length; i++)
            {
                float barHeight;    //hight of the bar
                barHeight = (values[i] / highestValue) * 190;

                //Draw the bar
                SolidBrush brush = new SolidBrush(Color.FromArgb(alpha, colorList[i]));
                graphicGraph.FillRectangle(brush, x, 194 - barHeight, 10, barHeight);

                //x axis spacing by 20
                x += 20;
            }

            //Increase the size of the canvas and draw axis
            objgraph = EmbedAxis(objgraph, true);

            //Draw the key-value pair with repective color code
            objgraph = EmbedXPanel(objgraph);

            return (objgraph);
        }

        //Generate 3D Bar graph
        public Bitmap Draw3dBarGraph()
        {

            Bitmap objgraph = new Bitmap(200, 200);             // Canvas for graph
            Bitmap objXValuePanel = new Bitmap(100, 200);       // Canvas to display x-axis values

            Graphics graphicGraph = Graphics.FromImage(objgraph);
            Graphics graphicXValuePanel = Graphics.FromImage(objXValuePanel);

            //Paint the graph canvas white
           // SolidBrush whiteBrush = new SolidBrush(Color.White);
           // graphicGraph.FillRectangle(whiteBrush, 0, 0, 200, 200);


            float highestValue; //Highest value in the values array

            //Get the highest value 
            float[] tempValue = new float[values.Length];
            for (int j = 0; j < values.Length; j++)
            {
                tempValue[j] = values[j];
            }
            Array.Sort<float>(tempValue);
            highestValue = tempValue[values.Length - 1];

            //Generate bar for each value
            for (int i = 0, x = 10; i < values.Length; i++)
            {
                SolidBrush brush = new SolidBrush(Color.FromArgb(alpha, colorList[i]));

                float barHeight;    //hight of the bar
                barHeight = (values[i] / highestValue) * 190;

                //Draw continuous shade for 3D effect
                float shadex = x + 10;
                float shadey = 194 - ((int)barHeight) + 10;
                for (int iLoop2 = 0; iLoop2 < 10; iLoop2++)
                {
                    graphicGraph.FillRectangle(brush, shadex - iLoop2, shadey - iLoop2, 10, barHeight);
                }


                //Draw bar
                graphicGraph.FillRectangle(new HatchBrush(HatchStyle.Percent50, brush.Color), x, 194 - barHeight, 10, barHeight);
               
                //Increment the x position            
                x += 20;

            }

            //Mask bottom with a white line
            Pen whitePen = new Pen(Color.White, 10);
            graphicGraph.DrawLine(whitePen, new Point(10, 200), new Point(230, 200));

            //Increase the size of the canvas and draw axis
            objgraph = EmbedAxis(objgraph, true);

            //Draw the key-value pair with repective color code
            objgraph = EmbedXPanel(objgraph);

            return (objgraph);


        }

        //Generate Bar + Line Graph
        public Bitmap DrawBarLineGraph(float[]newYValues,string []newXValues)
        {

            Bitmap objgraph = new Bitmap(200, 200); // Canvas for graph

            Graphics graphicGraph = Graphics.FromImage(objgraph);

            float highestValue; //Highest value in the values array

            //Get the highest value 
            float[] tempValue = new float[values.Length];
            for (int j = 0; j < values.Length; j++)
            {
                tempValue[j] = values[j];
            }
            Array.Sort<float>(tempValue);
            highestValue = tempValue[values.Length - 1];

            //Generate bar for each value
            for (int i = 0, x = 10; i < values.Length; i++)
            {
                float barHeight;    //hight of the bar
                barHeight = (values[i] / highestValue) * 190;

                //Draw the bar
                SolidBrush brush = new SolidBrush(Color.FromArgb(alpha, colorList[i]));
                graphicGraph.FillRectangle(brush, x, 194 - barHeight, 10, barHeight);

                //x axis spacing by 20
                x += 20;
            }
           
            //Start Drawing Line Graph
            float l_highestValue; //Highest value in the values array

            //Get the highest value 
            float[] l_tempValue = new float[newYValues.Length];
            for (int j = 0; j < newYValues.Length; j++)
            {
                l_tempValue[j] = (int)newYValues[j];
            }
            Array.Sort<float>(l_tempValue);
            l_highestValue = l_tempValue[newYValues.Length - 1];
            int[,] points = new int[newYValues.Length, 2];

            //Generate Linr for each value
            for (int i = 0, x = 10; i < newYValues.Length; i++)
            {

                decimal barHeight;    //hight of the point
                barHeight = (decimal)(newYValues[i] / highestValue * 190);

                points[i, 0] = x+3;
                barHeight = 194 - barHeight;
                points[i, 1] = (int)Decimal.Round(barHeight, 0);

                Font f = new Font(fontFormat, 8);
                graphicGraph.FillEllipse(Brushes.Yellow, points[i, 0] - 2, points[i, 1] - 2, 5, 5);
                
                x += 20;
            }

            for (int i = 1; i < newYValues.Length; i++)
            {
                Point startPoint = new Point(points[i - 1, 0], points[i - 1, 1]);
                Point endPoint = new Point(points[i, 0], points[i, 1]);
                SolidBrush brush = new SolidBrush(colorList[i+3]);
                Pen colorPen = new Pen(brush, 2);

                graphicGraph.DrawLine(colorPen, startPoint, endPoint);
            }
            
            //Increase the size of the canvas and draw axis
            objgraph = EmbedAxis(objgraph, true);

            //Draw the key-value pair with repective color code [Bar Graph]
            objgraph = EmbedXPanel(objgraph);
            //Draw the key-value pair with repective color code [Line Graph]
            objgraph =EmbedHoriXLinePanel(objgraph,newXValues) ;

            return (objgraph);
        }
        //Generate Pie graph
        public Bitmap DrawPieGraph()
        {
            Bitmap objgraph = new Bitmap(200, 200);

            Graphics graphicGraph = Graphics.FromImage(objgraph);
            
            // Create location and size of ellipse.
            int x = 0;
            int y = 0;
            int width = 200;
            int height = 100;

            // Create start and sweep angles.
            float sweepAngle = 0;
            float startAngle = 0;
            
            float total = 0; 
            for (int i = 0; i < values.Length; i++)
            {
                total += values[i];
            }
            for (int i = 0; i < values.Length; i++)
            {
                SolidBrush objBrush = new SolidBrush(colorList[i]);
                sweepAngle = (values[i] * 360) / total;
                graphicGraph.SmoothingMode = SmoothingMode.AntiAlias;
                graphicGraph.FillPie(objBrush, x, y, width, height, startAngle, sweepAngle);
                startAngle += sweepAngle;
            }

            //Increase the size of the canvas in which the graph resides
            objgraph = EmbedAxis(objgraph, false);

            //Draw the key-value pair with repective color code
            objgraph = EmbedXPanel(objgraph);

            return (objgraph);

        }

        //Generate Pie graph
        public Bitmap Draw3DPieGraph()
        {
            Bitmap objgraph = new Bitmap(200, 200);
            Graphics graphicGraph = Graphics.FromImage(objgraph);

            // Create location and size of ellipse.
            int x = 0;
            int y = 0;
            int width = 200;
            int height = 100;

            //Find the sum of all values
            float total = 0; 
            for (int i = 0; i < values.Length; i++)
            {
                total += values[i];
            }

            //When loop=0 :Draw shadow
            //     loop=1 :Draw graph
            for (int loop = 0; loop < 2; loop++)
            {
                // Create start and sweep angles.
                float sweepAngle = 0;
                float startAngle = 0;

                //Draw pie for each value
                for (int i = 0; i < values.Length; i++)
                {
                    SolidBrush objBrush = new SolidBrush(colorList[i]);
                    sweepAngle = (values[i] * 360) / total;

                    graphicGraph.SmoothingMode = SmoothingMode.AntiAlias;
                    if (loop == 0)
                    {
                        for (int iLoop2 = 0; iLoop2 < 10; iLoop2++)
                            graphicGraph.FillPie(new HatchBrush(HatchStyle.Percent50, objBrush.Color),
                                                x, y + iLoop2, width, height, startAngle, sweepAngle);
                    }
                    else
                    {
                        graphicGraph.FillPie(objBrush, x, y, width, height, startAngle, sweepAngle);
                    }

                    startAngle += sweepAngle;
                }
                    
            }

            //Increase the size of the canvas in which the graph resides
            objgraph = EmbedAxis(objgraph, false);

            //Draw the key-value pair with repective color code
            objgraph = EmbedXPanel(objgraph);

             return (objgraph);

         }

         //Generate Line graph
        public Bitmap DrawLineGraph()
        {
            Bitmap objgraph = new Bitmap(200, 200);             // Canvas for graph
            
            Graphics graphicGraph = Graphics.FromImage(objgraph);

            //Paint the graph canvas white
           // SolidBrush whiteBrush = new SolidBrush(Color.White);
            //graphicGraph.FillRectangle(whiteBrush, 0, 0, 200, 200);
            
            int highestValue; //Highest value in the values array

            //Get the highest value 
            int[] tempValue = new int[values.Length];
            for (int j = 0; j < values.Length; j++)
            {
                tempValue[j] = (int)values[j];
            }
            Array.Sort<int>(tempValue);
            highestValue = tempValue[values.Length - 1];
            int[,] points = new int[values.Length, 2];
            
            //Generate bar for each value
            for (int i = 0, x = 10; i < values.Length; i++)
            {

                decimal barHeight;    //hight of the bar
                barHeight = (decimal)(values[i] / highestValue * 190);

                points[i, 0] = x;
                barHeight = 194 - barHeight;
                points[i, 1] = (int)Decimal.Round(barHeight, 0);
                
                Font f = new Font(fontFormat, 8);
                graphicGraph.FillEllipse(Brushes.Black, points[i, 0]-2, points[i, 1]-2, 5, 5);
                graphicGraph.DrawString(values[i].ToString(), f, Brushes.Black, new Point(points[i, 0]-14, points[i, 1]-5));
                x += 20;
            }

            for (int i = 1; i < values.Length; i++)
            {
                Point startPoint = new Point(points[i - 1, 0], points[i - 1, 1]);
                Point endPoint = new Point(points[i, 0], points[i, 1]);
                SolidBrush brush = new SolidBrush(colorList[i]);
                Pen colorPen = new Pen(brush, 2);

                graphicGraph.DrawLine(colorPen, startPoint, endPoint);
            }
            
            objgraph = EmbedAxis(objgraph, true);
            objgraph = EmbedXLinePanel(objgraph);
            return (objgraph);

        }
       
     }
}

"@ -ReferencedAssemblies 'System.Windows.Forms.dll','System.Drawing.dll','System.Data.dll','System.Xml.dll'


Add-Type -TypeDefinition @"

// "
using System;
using System.Windows.Forms;
public class Win32Window : IWin32Window
{
    private IntPtr _hWnd;
    private string _data;

    public String Data
    {
        get { return _data; }
        set { _data = value; }
    }

    public Win32Window(IntPtr handle)
    {
        _hWnd = handle;
    }

    public IntPtr Handle
    {
        get { return _hWnd; }
    }
}

"@ -ReferencedAssemblies 'System.Windows.Forms.dll'

function DrawGraph {

  param(
    [string]$title,
    [string]$message,
    [object]$caller
  )

  @( 'System.Drawing','System.Windows.Forms') | ForEach-Object { [void][System.Reflection.Assembly]::LoadWithPartialName($_) }
  $f = New-Object System.Windows.Forms.Form
  $f.Text = $title


  $f.Size = New-Object System.Drawing.Size (470,335)
  $f.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::Font
  $f.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedToolWindow
  $f.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
  $f.SuspendLayout()

  $o = new-object -typename 'System.Anoop.Graph.DrawGraph' -ArgumentList @([string[]]@(
            "USA",
            "UK",
            "Japan",
            "China",
            "Bhutan",
            "India"),
            [float[]]@( 
             10,
             30,
             60,
             40,
             5 ,
             60),
             $null,
             $null,
             'Arial', 
             255
            )
  [System.Windows.Forms.PictureBox]$b = New-Object -TypeName 'System.Windows.Forms.PictureBox'
  $b.Location = New-Object System.Drawing.Point (20,20)
  $b.Name = 'p5'
  $b.Size = New-Object System.Drawing.Size (($f.Size.Width - 40),($f.Size.Height - 40))
  $b.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::AutoSize
  $b.TabIndex = 1
  $b.TabStop = $false
  

  $menustrip1 = New-Object -TypeName 'System.Windows.Forms.MenuStrip'
  $file_m1 = New-Object -TypeName 'System.Windows.Forms.ToolStripMenuItem'
  $about_m1 = New-Object -TypeName 'System.Windows.Forms.ToolStripMenuItem'
  $exit_m1 = New-Object -TypeName 'System.Windows.Forms.ToolStripMenuItem'
  $menustrip1.SuspendLayout()

  #  menuStrip1
  $menustrip1.Items.AddRange(@( $file_m1))
  $menustrip1.Location = New-Object System.Drawing.Point (0,0)
  $menustrip1.Name = "menuStrip1"
  $menustrip1.Size = New-Object System.Drawing.Size (($f.Size.Width),24)
  $menustrip1.TabIndex = 0
  $menustrip1.Text = "menuStrip1"


  #  aboutToolStripMenuItem
  $about_m1.Name = "aboutToolStripMenuItem"
  $about_m1.Text = "About"

  $eventMethod_about_m1 = $about_m1.add_click
  $eventMethod_about_m1.Invoke({
      param(
        [object]$sender,
        [System.EventArgs]$eventargs
      )
      $who = $sender.Text
      # [System.Windows.Forms.MessageBox]::Show(("We are processing {0}." -f $who))
      $b.Image = $o.DrawPieGraph()
      $caller.Data= $sender.Text
    })

  # Separator 
  $dash = new-object -typename System.Windows.Forms.ToolStripSeparator

  #  exitToolStripMenuItem
  $exit_m1.Name = "exitToolStripMenuItem"
  $exit_m1.Text = "Exit"

  $eventMethod_exit_m1 = $exit_m1.add_click
  $eventMethod_exit_m1.Invoke({
      param(
        [object]$sender,
        [System.EventArgs]$eventargs
      )
      $who = $sender.Text
      # [System.Windows.Forms.MessageBox]::Show(("We are processing {0}." -f $who))
      $caller.Data= $sender.Text
      $f.Close()
    })



  #  fileToolStripMenuItem1
  $file_m1.DropDownItems.AddRange(@( $about_m1, $dash, $exit_m1))
  $file_m1.Name = "fileToolStripMenuItem1"
  $file_m1.Text = "File"

  $menustrip1.ResumeLayout($false)

  #  MenuTest
  $f.AutoScaleDimensions = New-Object System.Drawing.SizeF (6,13)
  $f.Controls.Add($menustrip1)

#---


#---

  $f.Controls.AddRange(@($b))
  $f.Topmost = $True

  $f.Add_Shown({ $f.Activate() })

  [void]$f.ShowDialog([win32window]($caller))

  $f.Dispose()
}


$caller = New-Object Win32Window -ArgumentList ([System.Diagnostics.Process]::GetCurrentProcess().MainWindowHandle)

[void] (DrawGraph -Title $title -caller $caller)



