require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees
    attr_writer :funding, :employees
    def initialize(name, funding, salaries)#name = str, funding = number, salaries = hash
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        if salaries.has_key?(title)
            return true
        else
            return false
        end 
    end

    def >(other)
        if self.funding > other.funding
            return true 
        else
            return false
        end 
    end

    def hire(employee_name, employee_title)
       if !valid_title?(employee_title) 
        raise "error invalid title"
       else
        new_employee = Employee.new(employee_name, employee_title)
        employees << new_employee
       end   
    end

    def size
        employees.length
    end

    def pay_employee(emplye)
        if funding >= salaries[emplye.title]
            emplye.pay(salaries[emplye.title])
            self.funding -= salaries[emplye.title]
        else
            raise "error"
        end 
    end

    def payday
        employees.each { |employee| pay_employee(employee) }
    end

    def average_salary
        sum = 0
        employees.each do |employee| 
            sum += salaries[employee.title]
        end 
        sum / size.to_f
    end

    def close
        self.employees = []
        self.funding = 0
    end

    def acquire(other)
        self.funding += other.funding
        other.salaries.each do |title, amount|
            if !self.salaries.has_key?(title)
                self.salaries[title] = amount
            end
        end
        @employees = @employees + other.employees
        other.close
    end
end

