package controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import java.util.ArrayList;
public class ReadExcel{
    public static ArrayList<PhongThi> readPhongThi(String filename) throws IOException
	{
    	ArrayList<PhongThi> pt = new ArrayList<PhongThi>();
		InputStream ExcelFileToRead = new FileInputStream(filename);
		XSSFWorkbook  wb = new XSSFWorkbook(ExcelFileToRead);
		
		XSSFWorkbook test = new XSSFWorkbook(); 
		
		XSSFSheet sheet = wb.getSheetAt(0);
		XSSFRow row; 
		XSSFCell cell;

		Iterator rows = sheet.rowIterator();
		int i = 1;
		while (rows.hasNext())
		{
			row=(XSSFRow) rows.next();
			Iterator cells = row.cellIterator();
			ArrayList<String> ListRow = new ArrayList<String>();
			while (cells.hasNext())
			{
				cell=(XSSFCell)cells.next();
				ListRow.add(cell.getStringCellValue());
			}
			if(i != 1){
				if(ListRow.size() == 3){
					pt.add(new PhongThi(ListRow.get(0),Integer.parseInt(ListRow.get(1)),ListRow.get(2),""));
				}
				else{
					pt.add(new PhongThi(ListRow.get(0),Integer.parseInt(ListRow.get(1)),ListRow.get(2),ListRow.get(3)));
				}
			}
			i++;
		}
		return pt;
	}
	
    public static ArrayList<MonHoc> readMonHoc(String filename) throws IOException
   	{
       	ArrayList<MonHoc> mh = new ArrayList<MonHoc>();
   		InputStream ExcelFileToRead = new FileInputStream(filename);
   		XSSFWorkbook  wb = new XSSFWorkbook(ExcelFileToRead);
   		
   		XSSFWorkbook test = new XSSFWorkbook(); 
   		
   		XSSFSheet sheet = wb.getSheetAt(0);
   		XSSFRow row; 
   		XSSFCell cell;

   		Iterator rows = sheet.rowIterator();
   		int index = 1;
   		while (rows.hasNext())
   		{
   			row=(XSSFRow) rows.next();
   			Iterator cells = row.cellIterator();
   			ArrayList<String> ListRow = new ArrayList<String>();
   			while (cells.hasNext())
   			{
   				cell=(XSSFCell)cells.next();
   				ListRow.add(cell.getStringCellValue());
   			}
   			if(index !=1){
   				mh.add(new MonHoc(ListRow.get(0),ListRow.get(1),ListRow.get(2),ListRow.get(3),ListRow.get(4),ListRow.get(5),ListRow.get(6),ListRow.get(7),ListRow.get(8),ListRow.get(9)));
   			}
   			index++;
   		}
   		return mh;
   	}
}
