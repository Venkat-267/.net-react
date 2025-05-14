using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace Demo1
{
    internal class FileDemo
    {
        public static void Main() {
            string FilePath = @"C:\Users\venkat\test.txt";
            //FileStream fs = new FileStream(FilePath, FileMode.Create);
            //fs.Close();
            string data1 = "Orange";
            FileStream fs = new FileStream(FilePath, FileMode.Open,FileAccess.ReadWrite);
            StreamWriter sw = new StreamWriter(fs);
            sw.WriteLine(data1);
            sw.Close();
            fs.Close();

            fs = new FileStream(FilePath, FileMode.Open, FileAccess.Read);
            StreamReader streamReader = new StreamReader(fs);
            string data=streamReader.ReadLine();
            streamReader.Close();

            Console.WriteLine(data);
            
            fs.Close();

        }
    }
}
