//
//  LibxlwriterPage.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 06/07/16.
//  Copyright © 2016 Eugene Zorin. All rights reserved.
//

import Foundation

open class Libxlwriter: NSObject {

    let kFileExtension = "xlsx"

    var title: String {
        return "Faux Pas Exel converter"
    }

    var subtitle: String {
        return "The anatomy of a libxlsxwriter program"
    }

    var outputFileName: String {
        return "anatomy_swift"
    }

    var reportModel: ReportModel?

    internal var outputFilePath: String {
        get {
            let documentsFolderPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            guard let filePath = documentsFolderPath.stringByAppendingPathComponent(self.outputFileName).stringByAppendingPathExtension(kFileExtension)
                else {
                    return ""
            }

            return filePath
        }
    }

    public func createTitle(title: String, worksheet: UnsafeMutablePointer<lxw_worksheet>?, mainHeaderFormat: UnsafeMutablePointer<lxw_format>?) -> Int {
        // Write some unformatted data.
        /* Configure a format for the merged range. */
        format_set_align(mainHeaderFormat, UInt8(LXW_ALIGN_CENTER.rawValue))
        format_set_align(mainHeaderFormat, UInt8(LXW_ALIGN_VERTICAL_CENTER.rawValue))
        format_set_bold(mainHeaderFormat)
        format_set_bg_color(mainHeaderFormat, lxw_color_t(LXW_COLOR_YELLOW.rawValue))
        //format_set_border(ma, LXW_BORDER_THIN);
        /* Increase the cell size of the merged cells to highlight the formatting. */
        worksheet_set_column(worksheet, 0, 0, 25, nil)
        worksheet_set_row(worksheet, 0, 30, nil)
        /* Merge 3 cells. */
        worksheet_merge_range(worksheet, 0, 0, 0, 3, "Merged Range", mainHeaderFormat)

        worksheet_write_string(worksheet, 0, 0, title, mainHeaderFormat)

        return 1
    }

    public func createHeader(worksheet: UnsafeMutablePointer<lxw_worksheet>?,
                             format: UnsafeMutablePointer<lxw_format>?, startRow: UInt) -> Int {
      guard let headerList: [Dictionary<String, String?>] = self.reportModel?.headerList else {
        return 0
      }
        guard self.reportModel != nil, worksheet != nil else {
            return 0
        }
        var row = startRow

        worksheet_set_column(worksheet, 0, 0, 20, format)
        worksheet_set_column(worksheet, 1, 1, 20, format)
        for item in headerList {
            if let value = item.values.first, let key = item.keys.first {
                worksheet_write_string(worksheet, lxw_row_t(row), 1, value, format)
                worksheet_write_string(worksheet, lxw_row_t(row), 0, key, format)
                row += 1
            }
        }
        return Int(row)
    }

    public func createTimeStamp(worksheet: UnsafeMutablePointer<lxw_worksheet>?, row: Int, collum: Int, dateTimeFormat: UnsafeMutablePointer<lxw_format>?) -> Int {
        format_set_align(dateTimeFormat, UInt8(LXW_ALIGN_CENTER.rawValue))
        format_set_align(dateTimeFormat, UInt8(LXW_ALIGN_VERTICAL_CENTER.rawValue))
        format_set_num_format(dateTimeFormat, "mmm d yyyy hh:mm AM/PM")
        if let timeStamp = self.reportModel?.timeStamp {

            let calendar = Calendar(identifier: .gregorian)
            let date = Date(timeIntervalSince1970: timeStamp)

            var dateComponent = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: date)

            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss"
            dateFormatter.locale = Locale.current
            dateFormatter.timeZone = TimeZone.ReferenceType.local

            if let year1900 = dateFormatter.date(from: "1900-01-01T00:00:00"),
                let excelDateDays = year1900.numberOfDaysUntilDateTime(toDateTime: date, calendar: calendar),
                let hours = dateComponent.hour ,
                let minutes = dateComponent.minute,
                let seconds = dateComponent.second {
                let fractionalHours = Double(hours) + (Double(minutes) + (Double(seconds) / 60)) / 60
                let excelDate = Double(excelDateDays) + 2 + Double(fractionalHours) / 24
                worksheet_write_number(worksheet, lxw_row_t(row), lxw_col_t(collum + 1), excelDate, dateTimeFormat)
            } else {
                return 0
            }
        }
        worksheet_write_string(worksheet, lxw_row_t(row), lxw_col_t(collum), "Time Stamp:", nil)
        return row + 1
    }

    public func parseDemoMode() -> ReportModel? {
        let bundle = Bundle(for: type(of: self))
        if let theURL = bundle.url(forResource: "fauxPas", withExtension: "json") {
            do {
                let data = try Data(contentsOf: theURL)
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as? [String:Any] {
                    if let parsedData = parsedData {
                        return  ReportModel.modelObject(withDictionary: parsedData)
                    } else {
                        return nil
                    }
                }
            } catch {
                print(error)
                return nil
            }
        }
        return nil
    }

    public func createXlSheet() -> Void {
        guard let reportModel = parseDemoMode() else {
            return
        }
        self.reportModel      = reportModel
        let workbook          = new_workbook((outputFilePath as NSString).fileSystemRepresentation)

      let workSheetName  = "Diagnostics"
        // Add a worksheet with a user defined sheet name.
        let worksheet1        = workbook_add_worksheet(workbook, workSheetName)

        // Add a worksheet with Excel's default sheet name: Sheet2.
        let worksheet2        = workbook_add_worksheet(workbook, nil)

        // Add some cell formats.
        let mainHeaderFormat  = workbook_add_format(workbook)
        let myformat1         = workbook_add_format(workbook)
        let myformat2         = workbook_add_format(workbook)

        format_set_font_size(mainHeaderFormat, 16)
        format_set_bold(mainHeaderFormat)
        // Set the bold property for the first format.
        format_set_bold(myformat1)

        // Set a number format for the second format.
        format_set_num_format(myformat2, "$#,##0.00")
        var  lastRow = 0
        if let projectName = reportModel.projectName {
            lastRow = lastRow + createTitle(title: projectName, worksheet: worksheet1, mainHeaderFormat: mainHeaderFormat)
        }

        format_set_align(myformat1, UInt8(LXW_ALIGN_CENTER.rawValue))
        format_set_align(myformat1, UInt8(LXW_ALIGN_VERTICAL_CENTER.rawValue))

        lastRow          = createHeader(worksheet: worksheet1, format: nil, startRow: UInt(lastRow))
        let dateTimeFormat    = workbook_add_format(workbook)
        lastRow               = createTimeStamp(worksheet: worksheet1, row: lastRow, collum: 0, dateTimeFormat: dateTimeFormat)

        //worksheet_write_string(worksheet1, 5, 0, "Faux Pas Version:",  nil)
        //worksheet_write_string(worksheet1, 5, 1, self.reportModel?.fauxPasVersion,  myformat1)

        // Write to the second worksheet.
        worksheet_write_string(worksheet2, 0, 0, "Issues", myformat1)
      
      /* Write some data for the chart. */
      worksheet_write_number(worksheet1, lxw_row_t(lastRow), 0, 10, nil);
      worksheet_write_number(worksheet1, lxw_row_t(lastRow + 1), 0, 40, nil);
      worksheet_write_number(worksheet1, lxw_row_t(lastRow + 2), 0, 50, nil);
      worksheet_write_number(worksheet1, lxw_row_t(lastRow + 3), 0, 20, nil);
      worksheet_write_number(worksheet1, lxw_row_t(lastRow + 4), 0, 10, nil);
      worksheet_write_number(worksheet1, lxw_row_t(lastRow + 5), 0, 50, nil);
      
      /* Write some data for the chart. */
      worksheet_write_string(worksheet1, 7, 1, "Distribution", myformat1)
      
      /* Create a chart object. */
      let chart = workbook_add_chart(workbook, UInt8(LXW_CHART_LINE.rawValue));
      /* Configure the chart. */
      let series = chart_add_series(chart, UnsafeMutablePointer(mutating: "\(workSheetName)!$B$\(8):$B$\(8)"), UnsafeMutablePointer(mutating: "\(workSheetName)!$A$\(7):$A$\(10)"))
      chart_series_set_name (series, UnsafeMutablePointer(mutating:"Issues"))

      /* Insert the chart into the worksheet. */
      worksheet_insert_chart(worksheet1, 10, 0, chart)

        // Close the workbook, save the file and free any memory
        workbook_close(workbook)

        let urlPath         = [URL(fileURLWithPath: outputFilePath)]
        NSWorkspace.shared().activateFileViewerSelecting(urlPath)

        if outputFileName.runCommand(String(format: "%@ %@", "open", outputFilePath)).lengthOfBytes(using: .utf8) > 0 {

        }
    }
}
