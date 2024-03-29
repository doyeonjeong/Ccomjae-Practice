//
//  EmployeeDAO.swift
//  Chapter06-HR
//
//  Created by Doyeon on 2023/02/14.
//

enum EmpStateType: Int {
    case ING = 0, STOP, OUT
    
    /// 재직 상태를 문자열로 변환
    func desc() -> String {
        switch self {
        case .ING:
            return "재직중"
        case .STOP:
            return "휴직"
        case .OUT:
            return "퇴사"
        }
    }
}

struct EmployeeVO {
    var empCd = 0 // 사원코드
    var empName = "" // 사원명
    var joinDate = "" // 입사일
    var stateCd = EmpStateType.ING // 재직 상태 (기본값 : 재직중)
    var departCd = 0 // 부서 코드
    var departTitle = "" // 소속 부서명
}

class EmployeeDAO {
    
    lazy var fmdb: FMDatabase! = {
        let fileMgr = FileManager.default
        let docPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
        let dbPath = docPath!.appendingPathComponent("hr.sqlite").path
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "hr", ofType: "sqlite")
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        let db = FMDatabase(path: dbPath)
        return db
    }()
    
    init() {
        self.fmdb.open()
    }
    
    deinit {
        self.fmdb.close()
    }
    
    /// 사원 정보 불러오기
    func find(departCd: Int = 0) -> [EmployeeVO] {
        var employeeList = [EmployeeVO]()
        
        do {
            let condition = departCd == 0 ? "" : "WHERE Employee.depart_cd = \(departCd)"
            
            let sql = """
                SELECT emp_cd, emp_name, join_date, state_cd, department.depart_title
                  FROM employee
                  JOIN department On department.depart_cd = employee.depart_cd
                \(condition)
                 ORDER BY employee.depart_cd
            """
            
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            
            while rs.next() {
                var record = EmployeeVO()
                
                record.empCd = Int(rs.int(forColumn: "emp_cd"))
                record.empName = rs.string(forColumn: "emp_name")!
                record.joinDate = rs.string(forColumn: "join_date")!
                record.departTitle = rs.string(forColumn: "depart_title")!
                
                let cd = Int(rs.int(forColumn: "state_cd"))
                record.stateCd = EmpStateType(rawValue: cd)!
                
                employeeList.append(record)
            }
        } catch let error as NSError {
            print("failed : \(error.localizedDescription)")
        }
        return employeeList
    }
    
    /// 단일 사원 정보 불러오기
    func getOne(empCd: Int) -> EmployeeVO? {
        let sql = """
            SELECT emp_cd, emp_name, join_date, state_cd, department.depart_title
              FROM employee
              JOIN department On department.depart_cd = employee.depart_cd
             WHERE emp_cd = ?
        """
        
        let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [empCd])
        
        if let _rs = rs { // 결과가 옵셔널 타입이기 때문에 옵셔널 바인딩 필요
            _rs.next()
            
            var record = EmployeeVO()
            
            record.empCd = Int(_rs.int(forColumn: "emp_cd"))
            record.empName = _rs.string(forColumn: "emp_name")!
            record.joinDate = _rs.string(forColumn: "join_date")!
            record.departTitle = _rs.string(forColumn: "depart_title")!
            
            let cd = Int(_rs.int(forColumn: "state_cd"))
            record.stateCd = EmpStateType(rawValue: cd)!
            
            return record
        } else {
            return nil
        }
    }
    
    /// 신규 사원 추가
    func create(param: EmployeeVO) -> Bool {
        do {
            let sql = """
                INSERT INTO employee (emp_name, join_date, state_cd, depart_cd)
                VALUES ( ? , ? , ? , ? )
            """
            
            // Prepared Statenebt를 위한 인자갑
            var params = [Any]()
            params.append(param.empName)
            params.append(param.joinDate)
            params.append(param.stateCd.rawValue)
            params.append(param.departCd)
            
            try self.fmdb.executeUpdate(sql, values: params)
            return true
        } catch let error as NSError {
            print("Insert Error : \(error.localizedDescription)")
            return false
        }
    }
    
    /// 사원 정보 삭제
    func remove(empCd: Int) -> Bool {
        do {
            let sql = "DELETE FROM employee WHERE emp_cd = ? "
            try self.fmdb.executeUpdate(sql, values: [empCd])
            return true
        } catch let error as NSError {
            print("DELETE Error : \(error.localizedDescription)")
            return false
        }
    }
    
    /// 재직 상태 변경
    func editState(empCd: Int, stateCd: EmpStateType) -> Bool {
        do {
            let sql = " UPDATE Employee SET state_cd = ? WHERE emp_cd = ? "
            
            var params = [Any]()
            params.append(stateCd.rawValue)
            params.append(empCd)
            
            try self.fmdb.executeUpdate(sql, values: params)
            return true
        } catch let error as NSError {
            print("UPDATE Error : \(error.localizedDescription)")
            return false
        }
    }
}
