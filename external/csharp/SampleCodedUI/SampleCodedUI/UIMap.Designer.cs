﻿// ------------------------------------------------------------------------------
//  <auto-generated>
//      This code was generated by coded UI test builder.
//      Version: 10.0.0.0
//
//      Changes to this file may cause incorrect behavior and will be lost if
//      the code is regenerated.
//  </auto-generated>
// ------------------------------------------------------------------------------

namespace SampleCodedUI
{
    using System;
    using System.CodeDom.Compiler;
    using System.Collections.Generic;
    using System.Drawing;
    using System.Text.RegularExpressions;
    using System.Windows.Input;
    using Microsoft.VisualStudio.TestTools.UITest.Extension;
    using Microsoft.VisualStudio.TestTools.UITesting;
    using Microsoft.VisualStudio.TestTools.UITesting.WinControls;
    using Microsoft.VisualStudio.TestTools.UnitTesting;
    using Keyboard = Microsoft.VisualStudio.TestTools.UITesting.Keyboard;
    using Mouse = Microsoft.VisualStudio.TestTools.UITesting.Mouse;
    using MouseButtons = System.Windows.Forms.MouseButtons;
    
    
    [GeneratedCode("Coded UITest Builder", "10.0.40219.1")]
    public partial class UIMap
    {
        
        /// <summary>
        /// SampleCodedUITest - Use 'SampleCodedUITestParams' to pass parameters into this method.
        /// </summary>
        public void SampleCodedUITest()
        {
            #region Variable Declarations
            WinMenuItem uINewCtrlNMenuItem = this.UIUntitledNotepadWindow.UIApplicationMenuBar.UIFileMenuItem.UINewCtrlNMenuItem;
            WinEdit uIItemEdit = this.UIUntitledNotepadWindow.UIItemWindow.UIItemEdit;
            WinMenuItem uIFileMenuItem = this.UIUntitledNotepadWindow.UIApplicationMenuBar.UIFileMenuItem;
            WinMenuItem uIFontMenuItem = this.UIUntitledNotepadWindow.UIApplicationMenuBar.UIFormatMenuItem.UIFontMenuItem;
            WinComboBox uIFontComboBox = this.UIFontWindow.UIItemWindow.UIFontComboBox;
            WinComboBox uISizeComboBox = this.UIFontWindow.UIItemWindow1.UISizeComboBox;
            WinButton uIOKButton = this.UIFontWindow.UIOKWindow.UIOKButton;
            #endregion

            // Click 'File' -> 'New	Ctrl+N' menu item
            Mouse.Click(uINewCtrlNMenuItem, new Point(38, 10));

            // Type 'test' in 'Unknown Name' text box
            uIItemEdit.Text = this.SampleCodedUITestParams.UIItemEditText;

            // Click 'File' menu item
            Mouse.Click(uIFileMenuItem, new Point(14, 12));

            // Click 'Format' -> 'Font...' menu item
            Mouse.Click(uIFontMenuItem, new Point(31, 5));

            // Select 'Microsoft Sans Serif' in 'Font:' combo box
            uIFontComboBox.EditableItem = this.SampleCodedUITestParams.UIFontComboBoxEditableItem;

            // Select '14' in 'Size:' combo box
            uISizeComboBox.EditableItem = this.SampleCodedUITestParams.UISizeComboBoxEditableItem;

            // Click 'OK' button
            Mouse.Click(uIOKButton, new Point(60, 10));
        }
        
        #region Properties
        public virtual SampleCodedUITestParams SampleCodedUITestParams
        {
            get
            {
                if ((this.mSampleCodedUITestParams == null))
                {
                    this.mSampleCodedUITestParams = new SampleCodedUITestParams();
                }
                return this.mSampleCodedUITestParams;
            }
        }
        
        public UIUntitledNotepadWindow UIUntitledNotepadWindow
        {
            get
            {
                if ((this.mUIUntitledNotepadWindow == null))
                {
                    this.mUIUntitledNotepadWindow = new UIUntitledNotepadWindow();
                }
                return this.mUIUntitledNotepadWindow;
            }
        }
        
        public UIFontWindow UIFontWindow
        {
            get
            {
                if ((this.mUIFontWindow == null))
                {
                    this.mUIFontWindow = new UIFontWindow();
                }
                return this.mUIFontWindow;
            }
        }
        #endregion
        
        #region Fields
        private SampleCodedUITestParams mSampleCodedUITestParams;
        
        private UIUntitledNotepadWindow mUIUntitledNotepadWindow;
        
        private UIFontWindow mUIFontWindow;
        #endregion
    }
    
    /// <summary>
    /// Parameters to be passed into 'SampleCodedUITest'
    /// </summary>
    [GeneratedCode("Coded UITest Builder", "10.0.40219.1")]
    public class SampleCodedUITestParams
    {
        
        #region Fields
        /// <summary>
        /// Type 'test' in 'Unknown Name' text box
        /// </summary>
        public string UIItemEditText = "test";
        
        /// <summary>
        /// Select 'Microsoft Sans Serif' in 'Font:' combo box
        /// </summary>
        public string UIFontComboBoxEditableItem = "Microsoft Sans Serif";
        
        /// <summary>
        /// Select '14' in 'Size:' combo box
        /// </summary>
        public string UISizeComboBoxEditableItem = "14";
        #endregion
    }
    
    [GeneratedCode("Coded UITest Builder", "10.0.40219.1")]
    public class UIUntitledNotepadWindow : WinWindow
    {
        
        public UIUntitledNotepadWindow()
        {
            #region Search Criteria
            this.SearchProperties[WinWindow.PropertyNames.Name] = "Untitled - Notepad";
            this.SearchProperties[WinWindow.PropertyNames.ClassName] = "Notepad";
            this.WindowTitles.Add("Untitled - Notepad");
            #endregion
        }
        
        #region Properties
        public UIApplicationMenuBar UIApplicationMenuBar
        {
            get
            {
                if ((this.mUIApplicationMenuBar == null))
                {
                    this.mUIApplicationMenuBar = new UIApplicationMenuBar(this);
                }
                return this.mUIApplicationMenuBar;
            }
        }
        
        public UIItemWindow UIItemWindow
        {
            get
            {
                if ((this.mUIItemWindow == null))
                {
                    this.mUIItemWindow = new UIItemWindow(this);
                }
                return this.mUIItemWindow;
            }
        }
        #endregion
        
        #region Fields
        private UIApplicationMenuBar mUIApplicationMenuBar;
        
        private UIItemWindow mUIItemWindow;
        #endregion
    }
    
    [GeneratedCode("Coded UITest Builder", "10.0.40219.1")]
    public class UIApplicationMenuBar : WinMenuBar
    {
        
        public UIApplicationMenuBar(UITestControl searchLimitContainer) : 
                base(searchLimitContainer)
        {
            #region Search Criteria
            this.SearchProperties[WinMenu.PropertyNames.Name] = "Application";
            this.WindowTitles.Add("Untitled - Notepad");
            #endregion
        }
        
        #region Properties
        public UIFileMenuItem UIFileMenuItem
        {
            get
            {
                if ((this.mUIFileMenuItem == null))
                {
                    this.mUIFileMenuItem = new UIFileMenuItem(this);
                }
                return this.mUIFileMenuItem;
            }
        }
        
        public UIFormatMenuItem UIFormatMenuItem
        {
            get
            {
                if ((this.mUIFormatMenuItem == null))
                {
                    this.mUIFormatMenuItem = new UIFormatMenuItem(this);
                }
                return this.mUIFormatMenuItem;
            }
        }
        #endregion
        
        #region Fields
        private UIFileMenuItem mUIFileMenuItem;
        
        private UIFormatMenuItem mUIFormatMenuItem;
        #endregion
    }
    
    [GeneratedCode("Coded UITest Builder", "10.0.40219.1")]
    public class UIFileMenuItem : WinMenuItem
    {
        
        public UIFileMenuItem(UITestControl searchLimitContainer) : 
                base(searchLimitContainer)
        {
            #region Search Criteria
            this.SearchProperties[WinMenuItem.PropertyNames.Name] = "File";
            this.WindowTitles.Add("Untitled - Notepad");
            #endregion
        }
        
        #region Properties
        public WinMenuItem UINewCtrlNMenuItem
        {
            get
            {
                if ((this.mUINewCtrlNMenuItem == null))
                {
                    this.mUINewCtrlNMenuItem = new WinMenuItem(this);
                    #region Search Criteria
                    this.mUINewCtrlNMenuItem.SearchProperties[WinMenuItem.PropertyNames.Name] = "New\tCtrl+N";
                    this.mUINewCtrlNMenuItem.SearchConfigurations.Add(SearchConfiguration.ExpandWhileSearching);
                    this.mUINewCtrlNMenuItem.WindowTitles.Add("Untitled - Notepad");
                    #endregion
                }
                return this.mUINewCtrlNMenuItem;
            }
        }
        #endregion
        
        #region Fields
        private WinMenuItem mUINewCtrlNMenuItem;
        #endregion
    }
    
    [GeneratedCode("Coded UITest Builder", "10.0.40219.1")]
    public class UIFormatMenuItem : WinMenuItem
    {
        
        public UIFormatMenuItem(UITestControl searchLimitContainer) : 
                base(searchLimitContainer)
        {
            #region Search Criteria
            this.SearchProperties[WinMenuItem.PropertyNames.Name] = "Format";
            this.WindowTitles.Add("Untitled - Notepad");
            #endregion
        }
        
        #region Properties
        public WinMenuItem UIFontMenuItem
        {
            get
            {
                if ((this.mUIFontMenuItem == null))
                {
                    this.mUIFontMenuItem = new WinMenuItem(this);
                    #region Search Criteria
                    this.mUIFontMenuItem.SearchProperties[WinMenuItem.PropertyNames.Name] = "Font...";
                    this.mUIFontMenuItem.SearchConfigurations.Add(SearchConfiguration.ExpandWhileSearching);
                    this.mUIFontMenuItem.WindowTitles.Add("Untitled - Notepad");
                    #endregion
                }
                return this.mUIFontMenuItem;
            }
        }
        #endregion
        
        #region Fields
        private WinMenuItem mUIFontMenuItem;
        #endregion
    }
    
    [GeneratedCode("Coded UITest Builder", "10.0.40219.1")]
    public class UIItemWindow : WinWindow
    {
        
        public UIItemWindow(UITestControl searchLimitContainer) : 
                base(searchLimitContainer)
        {
            #region Search Criteria
            this.SearchProperties[WinWindow.PropertyNames.ControlId] = "15";
            this.WindowTitles.Add("Untitled - Notepad");
            #endregion
        }
        
        #region Properties
        public WinEdit UIItemEdit
        {
            get
            {
                if ((this.mUIItemEdit == null))
                {
                    this.mUIItemEdit = new WinEdit(this);
                    #region Search Criteria
                    this.mUIItemEdit.WindowTitles.Add("Untitled - Notepad");
                    #endregion
                }
                return this.mUIItemEdit;
            }
        }
        #endregion
        
        #region Fields
        private WinEdit mUIItemEdit;
        #endregion
    }
    
    [GeneratedCode("Coded UITest Builder", "10.0.40219.1")]
    public class UIFontWindow : WinWindow
    {
        
        public UIFontWindow()
        {
            #region Search Criteria
            this.SearchProperties[WinWindow.PropertyNames.Name] = "Font";
            this.SearchProperties[WinWindow.PropertyNames.ClassName] = "#32770";
            this.WindowTitles.Add("Font");
            #endregion
        }
        
        #region Properties
        public UIItemWindow1 UIItemWindow
        {
            get
            {
                if ((this.mUIItemWindow == null))
                {
                    this.mUIItemWindow = new UIItemWindow1(this);
                }
                return this.mUIItemWindow;
            }
        }
        
        public UIItemWindow11 UIItemWindow1
        {
            get
            {
                if ((this.mUIItemWindow1 == null))
                {
                    this.mUIItemWindow1 = new UIItemWindow11(this);
                }
                return this.mUIItemWindow1;
            }
        }
        
        public UIOKWindow UIOKWindow
        {
            get
            {
                if ((this.mUIOKWindow == null))
                {
                    this.mUIOKWindow = new UIOKWindow(this);
                }
                return this.mUIOKWindow;
            }
        }
        #endregion
        
        #region Fields
        private UIItemWindow1 mUIItemWindow;
        
        private UIItemWindow11 mUIItemWindow1;
        
        private UIOKWindow mUIOKWindow;
        #endregion
    }
    
    [GeneratedCode("Coded UITest Builder", "10.0.40219.1")]
    public class UIItemWindow1 : WinWindow
    {
        
        public UIItemWindow1(UITestControl searchLimitContainer) : 
                base(searchLimitContainer)
        {
            #region Search Criteria
            this.SearchProperties[WinWindow.PropertyNames.ControlId] = "1136";
            this.WindowTitles.Add("Font");
            #endregion
        }
        
        #region Properties
        public WinComboBox UIFontComboBox
        {
            get
            {
                if ((this.mUIFontComboBox == null))
                {
                    this.mUIFontComboBox = new WinComboBox(this);
                    #region Search Criteria
                    this.mUIFontComboBox.SearchProperties[WinComboBox.PropertyNames.Name] = "Font:";
                    this.mUIFontComboBox.WindowTitles.Add("Font");
                    #endregion
                }
                return this.mUIFontComboBox;
            }
        }
        #endregion
        
        #region Fields
        private WinComboBox mUIFontComboBox;
        #endregion
    }
    
    [GeneratedCode("Coded UITest Builder", "10.0.40219.1")]
    public class UIItemWindow11 : WinWindow
    {
        
        public UIItemWindow11(UITestControl searchLimitContainer) : 
                base(searchLimitContainer)
        {
            #region Search Criteria
            this.SearchProperties[WinWindow.PropertyNames.ControlId] = "1138";
            this.WindowTitles.Add("Font");
            #endregion
        }
        
        #region Properties
        public WinComboBox UISizeComboBox
        {
            get
            {
                if ((this.mUISizeComboBox == null))
                {
                    this.mUISizeComboBox = new WinComboBox(this);
                    #region Search Criteria
                    this.mUISizeComboBox.SearchProperties[WinComboBox.PropertyNames.Name] = "Size:";
                    this.mUISizeComboBox.WindowTitles.Add("Font");
                    #endregion
                }
                return this.mUISizeComboBox;
            }
        }
        #endregion
        
        #region Fields
        private WinComboBox mUISizeComboBox;
        #endregion
    }
    
    [GeneratedCode("Coded UITest Builder", "10.0.40219.1")]
    public class UIOKWindow : WinWindow
    {
        
        public UIOKWindow(UITestControl searchLimitContainer) : 
                base(searchLimitContainer)
        {
            #region Search Criteria
            this.SearchProperties[WinWindow.PropertyNames.ControlId] = "1";
            this.WindowTitles.Add("Font");
            #endregion
        }
        
        #region Properties
        public WinButton UIOKButton
        {
            get
            {
                if ((this.mUIOKButton == null))
                {
                    this.mUIOKButton = new WinButton(this);
                    #region Search Criteria
                    this.mUIOKButton.SearchProperties[WinButton.PropertyNames.Name] = "OK";
                    this.mUIOKButton.WindowTitles.Add("Font");
                    #endregion
                }
                return this.mUIOKButton;
            }
        }
        #endregion
        
        #region Fields
        private WinButton mUIOKButton;
        #endregion
    }
}