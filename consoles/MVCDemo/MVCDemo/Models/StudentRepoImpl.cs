using MVCDemo.Models;

namespace MVCDemo.Models
{
    public class StudentRepoImpl : IStudentRepo
    {
        private readonly ApplicationDbContext _context;

        public StudentRepoImpl(ApplicationDbContext context)
        {
            _context = context;
        }

        public Student GetStudentById(int Sid)
        {
            return _context.Students.FirstOrDefault(s => s.Id == Sid) ?? new Student();
        }

        public List<Student> GetAllStudents()
        {
            return _context.Students.ToList();
        }

        public void AddStudent(Student student)
        {
            _context.Students.Add(student);
            _context.SaveChanges();
        }

        public void UpdateStudent(Student student)
        {
            _context.Students.Update(student);
            _context.SaveChanges();
        }

        public void DeleteStudent(int Sid)
        {
            var student = _context.Students.Find(Sid);
            if (student != null)
            {
                _context.Students.Remove(student);
                _context.SaveChanges();
            }
        }
    }
}
