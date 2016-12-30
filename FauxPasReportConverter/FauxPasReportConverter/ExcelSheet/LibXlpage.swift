//
//  LibXlpage.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 06/07/16.
//  Copyright © 2016 Eugene Zorin. All rights reserved.
//

import Foundation
import Darwin

open class LibXl: NSObject {
    override init() {
        super.init()
    }
    
    fileprivate var exelFormat : NSMatrix?
    
    open func createXlSheet() -> Void {
        let xlsMode : Bool = (exelFormat?.selectedCell()?.tag) != 0
        
        let book :  BookHandle = xlsMode ? xlCreateBookCA() : xlCreateXMLBookCA()
        
        let boldFont : FontHandle = xlBookAddFontA(book, nil)
        xlFontSetBoldA(boldFont, 1)
        
        let titleFont : FontHandle = xlBookAddFontA(book, nil)
        xlFontSetNameA(titleFont, "Arial Black")
        xlFontSetSizeA(titleFont, 16);
        
        let titleFormat : FontHandle = xlBookAddFormatA(book, nil)
        xlFormatSetFontA(titleFormat, titleFont);
        
        let headerFormat : FontHandle = xlBookAddFormatA(book, nil)
        
        xlFormatSetAlignHA(headerFormat, Int32(ALIGNH_CENTER.rawValue))
        xlFormatSetBorderA(headerFormat, Int32(BORDERSTYLE_THIN.rawValue))
        xlFormatSetFontA(headerFormat, boldFont)
        xlFormatSetFillPatternA(headerFormat,  Int32(FILLPATTERN_SOLID.rawValue))
        xlFormatSetPatternForegroundColorA(headerFormat,  Int32(COLOR_TAN.rawValue))
        
        let descriptionFormat : FormatHandle = xlBookAddFormatA(book, nil)
        xlFormatSetBorderLeftA(descriptionFormat, Int32(BORDERSTYLE_THIN.rawValue))
        
        let amountFormat : FontHandle = xlBookAddFormatA(book, nil);
        xlFormatSetNumFormatA(amountFormat, Int32(NUMFORMAT_CURRENCY_NEGBRA.rawValue))
        xlFormatSetBorderLeftA(amountFormat, Int32(BORDERSTYLE_THIN.rawValue))
        xlFormatSetBorderRightA(amountFormat, Int32(BORDERSTYLE_THIN.rawValue))
        
        let totalLabelFormat = xlBookAddFormatA(book, nil)
        xlFormatSetBorderTopA(totalLabelFormat, Int32(BORDERSTYLE_THIN.rawValue))
        xlFormatSetAlignHA(totalLabelFormat, Int32(ALIGNH_RIGHT.rawValue))
        xlFormatSetFontA(totalLabelFormat, boldFont);
        
        let totalFormat = xlBookAddFormatA(book, nil)
        xlFormatSetNumFormatA(totalFormat, Int32(NUMFORMAT_CURRENCY_NEGBRA.rawValue))
        xlFormatSetBorderA(totalFormat, Int32(BORDERSTYLE_THIN.rawValue))
        xlFormatSetFontA(totalFormat, boldFont)
        xlFormatSetFillPatternA(totalFormat, Int32(FILLPATTERN_SOLID.rawValue))
        xlFormatSetPatternForegroundColorA(totalFormat, Int32(COLOR_YELLOW.rawValue))
        
        let signatureFormat = xlBookAddFormatA(book, nil);
        xlFormatSetAlignHA(signatureFormat, Int32(ALIGNH_CENTER.rawValue));
        xlFormatSetBorderTopA(signatureFormat, Int32(BORDERSTYLE_THIN.rawValue));
        
        let sheet : SheetHandle? = xlBookAddSheetA(book, "Invoice", nil)
        if sheet != nil {
            
            xlSheetWriteStrA(sheet, 2, 1, "Invoice No. 3568", titleFormat)
            
            xlSheetWriteStrA(sheet, 4, 1, "Name: John Smith", nil)
            xlSheetWriteStrA(sheet, 5, 1, "Address: San Ramon, CA 94583 USA", nil)
            
            xlSheetWriteStrA(sheet, 7, 1, "Description", headerFormat)
            xlSheetWriteStrA(sheet, 7, 2, "Amount", headerFormat)
            
            xlSheetWriteStrA(sheet, 8, 1, "Ball-Point Pens", descriptionFormat)
            xlSheetWriteNumA(sheet, 8, 2, 85, amountFormat);
            xlSheetWriteStrA(sheet, 9, 1, "T-Shirts", descriptionFormat)
            xlSheetWriteNumA(sheet, 9, 2, 150, amountFormat);
            xlSheetWriteStrA(sheet, 10, 1, "Tea cups", descriptionFormat)
            xlSheetWriteNumA(sheet, 10, 2, 45, amountFormat);
            
            xlSheetWriteStrA(sheet, 11, 1, "Total:", totalLabelFormat)
            xlSheetWriteFormulaA(sheet, 11, 2, "=SUM(C9:C11)", totalFormat)
            
            xlSheetWriteStrA(sheet, 14, 2, "Signature", signatureFormat)
            
            xlSheetSetColA(sheet, 1, 1, 40, nil, 0)
            xlSheetSetColA(sheet, 2, 2, 15, nil, 0)
        }
        
        let name : String = xlsMode ? "invoice.xls" : "invoice.xlsx"
        let documentPath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        //NSSearchPathForDirectoriesInDomains(DocumentDirectory,UserDomainMask, YES) objectAtIndex:0];
        let filename = documentPath + "/" + name;
      
        xlBookSaveA(book, (filename.data(using: .utf8)! as Data).withUnsafeBytes {(bytes: UnsafePointer<Int8>)->UnsafePointer<Int8> in
          return bytes
      })
      
        xlBookReleaseA(book);
        
        NSWorkspace.shared().openFile(filename)

    }
}
