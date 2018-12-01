class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  

  # DB[:conn].exceute #tells SQL lite we want to run that SQL query 
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil) #default value needs to be last
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table
    #sql is the variable
    sql = <<-SQL 
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
    ); #needs a semicolon
    SQL
    DB[:conn].execute(sql)
  end

  # <<- HEREDOC statement ....... HEREDOC

  def self.drop_table 
    sql = <<-SQL
    DROP TABLE students
    SQL

    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
    INSERT INTO students (name,grade) VALUES (?,?)
    SQL
    DB[:conn].execute(sql,self.name,self.grade)
    @id = DB[:conn].last_insert_row_id()[0][0] #whattt????
        #dont forget to use @id not id
  end

  def self.create(hash)
    subclass = self.new(hash[:name], hash[:grade])
    subclass.save
    subclass

  end
  
end
