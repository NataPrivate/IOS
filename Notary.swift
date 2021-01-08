import Foundation


public enum NotaryError: Error {
    case runtimeError(String)
}


public protocol WithId {
    var id: Int? { get set }
}

public protocol Repo {
    associatedtype Entity
    func Add(_ item: inout Entity)
    func Update(_ item: Entity)
    func Remove(item: Entity)
    func Remove(id: Int)
    func Get(_ id: Int) -> Entity?
    func GetAll() -> [Entity]
}

public class BaseRepo<T : WithId> : Repo {
    public typealias Entity = T
    private var lastId: Int = 0
    public var items: [T] = []
    
    public func Add(_ item: inout Entity) {
        if (item.id == nil) {
            lastId = lastId + 1
            item.id = lastId 
            items.append(item)
        }
    }
    public func Update(_ item: Entity) {
        for (index, i) in items.enumerated() {
            if (i.id == item.id) {
                items[index] = item
                break
            }
        }
    }
    public func Remove(item: Entity) {
        for (index, i) in items.enumerated() {
            if (i.id == item.id) {
                items.remove(at: index)
                break
            }
        }
    }
    public func Remove(id: Int) {
        for (index, i) in items.enumerated() {
            if (i.id == id) {
                items.remove(at: index)
                break
            }
        }
    }
    public func Get(_ id: Int) -> Entity? {
        for i in items {
            if (i.id == id) {
                return i
            }
        }
        return nil
    }
    public func GetAll() -> [Entity] {
        return items
    }
}

public class AgreementRepo : BaseRepo<Agreement> {
    public func GetAllByIdClient(_ idClient: Int) -> [Agreement] {
        return items.filter {$0.idClient == idClient}
    }
}
public class ServicePriceRepo : BaseRepo<ServicePrice> {
    public func GetAllByIdService(_ idService: Int) -> [ServicePrice] {
        return items.filter {$0.idService == idService}
    }
}
public class Agreement_ServiceRepo : BaseRepo<Agreement_Service> {
    public func GetAllByIdAgreement(_ idAgreement: Int) -> [Service] {
        var result : [Service] = []
        for i in items {
            if (i.idAgreement == idAgreement) {
                result.append(i.service!)
            }
        }
        return result
    }
    public func GetAllByIdService(_ idService: Int) -> [Agreement] {        
        var result : [Agreement] = []
        for i in items {
            if (i.idService == idService) {
                result.append(i.agreement!)
            }
        }
        return result
    }
}

public class ActivityKind : WithId {
    private var _id: Int?
    private var _name: String?
    
    public var id: Int? {
        get {
            return self._id;
        }
        set {
            if newValue == nil || newValue! < 0  {
                fatalError("Invalid value for id")
            } else {
                self._id = newValue
            }
        }
    }
    public var name: String? {
        get {
            return self._name;
        }
        set {
            self._name = newValue
        }
    }
}
public class Client : WithId {
    private var _id: Int?
    private var _name: String?
    private var _phoneNumber: String?
    private var _address: String?
    private var _idActivity: Int?
    private var activitiesRepo: BaseRepo<ActivityKind>
    private var agreementsRepo: AgreementRepo
    
    init (_ activitiesRepo: BaseRepo<ActivityKind>, _ agreementsRepo : AgreementRepo) {
        self.activitiesRepo = activitiesRepo
        self.agreementsRepo = agreementsRepo
    }
    
    public var id: Int? {
        get {
            return self._id;
        }
        set {
            if newValue == nil || newValue! < 0  {
                fatalError("Invalid value for id")
            } else {
                self._id = newValue
            }
        }
    }
    public var name: String? {
        get {
            return self._name;
        }
        set {
            self._name = newValue
        }
    }
    public var phoneNumber: String? {
        get {
            return self._phoneNumber;
        }
        set {
            self._phoneNumber = newValue
        }
    }
    public var address: String? {
        get {
            return self._address;
        }
        set {
            self._address = newValue
        }
    }
    public var idActivity: Int? {
        get {
            return self._idActivity;
        }
        set {
            self._idActivity = newValue
        }
    }
    public var activity: ActivityKind? {
        get {
            return activitiesRepo.Get(_idActivity!)
        }
    }
    public var agreements: [Agreement] {
        get {
            return agreementsRepo.GetAllByIdClient(_id!)
        }
    }
}

public class ServicePrice : WithId {
    private var _id: Int?
    private var _idService: Int?
    private var _dateBegin: Date?
    private var _dateEnd: Date?
    private var _price: Double?
    private var _comissionPercent : Double?
    
    public var id: Int? {
        get {
            return self._id;
        }
        set {
            if newValue == nil || newValue! < 0  {
                fatalError("Invalid value for id")
            } else {
                self._id = newValue
            }
        }
    }
    public var idService: Int? {
        get {
            return self._idService;
        }
        set {
            self._idService = newValue
        }
    }
    public var dateBegin: Date? {
        get {
            return self._dateBegin;
        }
        set {
            self._dateBegin = newValue
        }
    }
    public var dateEnd: Date? {
        get {
            return self._dateEnd;
        }
        set {
            self._dateEnd = newValue
        }
    }
    public var price: Double? {
        get {
            return self._price;
        }
        set {
            self._price = newValue
        }
    }
    public var comissionPercent : Double? {
        get {
            return self._comissionPercent;
        }
        set {
            self._comissionPercent = newValue
        }
    }
}
public class Service : WithId {
    private var _id: Int?
    private var _name: String?
    private var _description: String?
    private var pricesRepo: ServicePriceRepo
    
    init (_ pricesRepo : ServicePriceRepo) {
        self.pricesRepo = pricesRepo
    }
    
    public var id: Int? {
        get {
            return self._id;
        }
        set {
            if newValue == nil || newValue! < 0  {
                fatalError("Invalid value for id")
            } else {
                self._id = newValue
            }
        }
    }
    public var name: String? {
        get {
            return self._name;
        }
        set {
            self._name = newValue
        }
    }
    public var description: String? {
        get {
            return self._description;
        }
        set {
            self._description = newValue
        }
    }
    public var prices: [ServicePrice] {
        get {
            return pricesRepo.GetAllByIdService(_id!)
        }
    }
    
    public func calculatePrice(client: Client?, date: Date = Date()) throws -> Double {
        for p in prices {
            if ((p.dateBegin! ... p.dateEnd!).contains(date)) {
                return p.price!
            }
        }
        throw NotaryError.runtimeError("no price for this date defined") 
    }    
    public func calculateComission(client: Client?, date: Date = Date()) throws -> Double {
        for p in prices {
            if ((p.dateBegin! ... p.dateEnd!).contains(date)) {
                return p.price!*p.comissionPercent!
            }
        }
        throw NotaryError.runtimeError("no price for this date defined") 
    }
}

public class Agreement_Service : WithId {
    private var _id: Int?
    private var _idAgreement: Int?
    private var _idService: Int?
    private var servicesRepo: BaseRepo<Service>
    private var agreementsRepo: AgreementRepo
    
    init (_ servicesRepo: BaseRepo<Service>, _ agreementsRepo : AgreementRepo) {
        self.servicesRepo = servicesRepo
        self.agreementsRepo = agreementsRepo
    }
    
    public var id: Int? {
        get {
            return self._id;
        }
        set {
            if newValue == nil || newValue! < 0  {
                fatalError("Invalid value for id")
            } else {
                self._id = newValue
            }
        }
    }
    public var idAgreement: Int? {
        get {
            return self._idAgreement;
        }
        set {
            self._idAgreement = newValue
        }
    }
    public var idService: Int? {
        get {
            return self._idService;
        }
        set {
            self._idService = newValue
        }
    }
    public var agreement: Agreement? {
        get {        
            return agreementsRepo.Get(_idAgreement!)
        }
    }
    public var service: Service? {
        get {            
            return servicesRepo.Get(_idService!)
        }
    }
}

public class Agreement : WithId {
    private var _id: Int?
    private var _date: Date = Date() 
    private var _description: String?
    private var _idClient: Int?
    private var _services: [Agreement_Service] = []
    private var linksRepo: Agreement_ServiceRepo
    private var clientsRepo: BaseRepo<Client>
    
    init (_ linksRepo: Agreement_ServiceRepo, _ clientsRepo : BaseRepo<Client>) {
        self.linksRepo = linksRepo
        self.clientsRepo = clientsRepo
    }
    
    public var id: Int? {
        get {
            return self._id;
        }
        set {
            if newValue == nil || newValue! < 0  {
                fatalError("Invalid value for id")
            } else {
                self._id = newValue
            }
        }
    }
    public var date: Date {
        get {
            return self._date;
        }
        set {
            self._date = newValue
        }
    }
    public var description: String? {
        get {
            return self._description;
        }
        set {
            self._description = newValue
        }
    }
    public var idClient: Int? {
        get {
            return self._idClient;
        }
        set {
            self._idClient = newValue
        }
    }
    public var client: Client? {
        get {
           return clientsRepo.Get(_idClient!)
        }
    }
    public var services: [Service] {
        get {
           return linksRepo.GetAllByIdAgreement(_id!)
        }
    }
    
    
    public func getServiceSum() throws -> Double {
        var sum: Double = 0
        for service in services {
            sum += try service.calculatePrice(client: client!, date: date)
        }
        return sum
    }
    public func getComissionSum() throws -> Double {
        var sum: Double = 0
        for service in services {
            sum += try service.calculateComission(client: client!, date: date)
        }
        return sum
    }
    public func getTotalSum() throws -> Double {
        var sum: Double = 0
        for service in services {
            sum += try service.calculatePrice(client: client!, date: date)
            sum += try service.calculateComission(client: client!, date: date)
        }
        return sum
    }
}



var activitiesRepo = BaseRepo<ActivityKind>()
var clientsRepo  = BaseRepo<Client>()
var pricesRepo = ServicePriceRepo()
var servicesRepo = BaseRepo<Service>()
var agreementsRepo = AgreementRepo()
var sp_linksRepo = Agreement_ServiceRepo()


func initEntities() {
    var act1 = ActivityKind()
    act1.name = "інженер"
    var act2 = ActivityKind()
    act2.name = "вчитель"
    var act3 = ActivityKind()
    act3.name = "механік"
    activitiesRepo.Add(&act1)
    activitiesRepo.Add(&act2)
    activitiesRepo.Add(&act3)
    
    var cl1: Client = Client(activitiesRepo,agreementsRepo)
    cl1.name = "Том"
    cl1.address = "Kiew, vul. Haharina, 6"
    cl1.phoneNumber = "5432867"
    cl1.idActivity = act1.id
    var cl2: Client = Client(activitiesRepo,agreementsRepo)
    cl2.name = "Jinny"
    cl2.address = "The Earth"
    cl2.idActivity = act2.id
    clientsRepo.Add(&cl1)
    clientsRepo.Add(&cl2)
    
    var pr1 = ServicePrice()
    pr1.idService = 1
    pr1.price = 500.0
    pr1.comissionPercent = 0.1
    pr1.dateBegin = Date()
    pr1.dateEnd = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: pr1.dateBegin!)
    var pr2 = ServicePrice()
    pr2.idService = 2
    pr2.price = 1400.0
    pr2.comissionPercent = 0.15
    pr2.dateBegin = Date()
    pr2.dateEnd = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: pr2.dateBegin!)
    pricesRepo.Add(&pr1)
    pricesRepo.Add(&pr2)
    
    var s1 = Service(pricesRepo)
    s1.name = "Консультація"
    var s2 = Service(pricesRepo)
    s2.name = "Переоформлення документів про майно"
    servicesRepo.Add(&s1)
    servicesRepo.Add(&s2)
    
    var a1 = Agreement(sp_linksRepo,clientsRepo)
    a1.description = "Договір на отримання консультація"
    a1.idClient = cl1.id
    agreementsRepo.Add(&a1)
    
    var lk1 = Agreement_Service(servicesRepo,agreementsRepo)
    lk1.idAgreement = a1.id
    lk1.idService = s1.id
    sp_linksRepo.Add(&lk1)
}

func applyAgreement(agreement: Agreement)  {
    
}
func printClients() {
    for i in clientsRepo.GetAll() {
        print("\(i.id!): \(i.name!) living at \(i.address!) with phone number \(i.phoneNumber == nil ? "unknow": i.phoneNumber!)")
    }
}
func printAgreements(_ idClient: Int)throws {
    let client = clientsRepo.Get(idClient)!
    print("Договори для клієнта \(client.name!)")
    if client.agreements.count > 0 {
        for i in client.agreements {
            print("\(i.id!): \(i.description!) at \(i.date) costing \(try i.getTotalSum())")
        }
    }
    else {
        print("Ще немає договорів")
    }
}

func printServices(_ idAgreement: Int) throws {
    let agreement = agreementsRepo.Get(idAgreement)!
    print("Послуги за договором \(agreement.description!)")
    if agreement.services.count > 0 {
        for i in agreement.services {
            print("\(i.id!): \(i.name!), price=\(try i.calculatePrice(client : agreement.client!)), comission=\(try i.calculateComission(client : agreement.client!))")
        }
    }
    else {
        print("Ще немає послуг")
    }
}
func printServices() throws {
    for i in servicesRepo.GetAll() {
        print("\(i.id!): \(i.name!), price=\(try i.calculatePrice(client:nil)), comission=\(try i.calculateComission(client:nil))")
    }
}


func AllClients() throws {
    print("enter id")
    if let o=readLine()
    {
        if let i=Int(o){
            if i>0{
                try printAgreements(i)
                return
                
            }
        }
        
    }
    print("ERROR")
}
func AgrByClientId() throws {
    print("enter id")
    if let o=readLine()
    {
        if let i=Int(o){
            if i>0{
                try printAgreements(i)
            }
        }
        
    }
    print("ERROR")
}

func SrvByAgrId() throws {
    print("enter agreement id")
    if let o=readLine()
    {
        if let i=Int(o){
            if i>0{
                try printServices(i)
                return
                
            }
        }
        
    }
    print("ERROR")
}

func AddAgr() throws {
    var agr = Agreement(sp_linksRepo,clientsRepo)
    print("enter description")
    if let o=readLine() {
        agr.description = o;
        agreementsRepo.Add(&agr)
        print("enter client id")
        if let o=readLine()
        {
            if let i=Int(o){
                if i>0{    
                    let client = clientsRepo.Get(i)!
                    agr.idClient = client.id!
                    print("\(client.id!): \(client.name!) living at \(client.address!) with phone number \(client.phoneNumber == nil ? "unknow": client.phoneNumber!)")
                    print("select srvs")
                    try printServices()
                    if let o1=readLine()
                    {
                        let srvs=o1.components(separatedBy: " ")
                        for srv in srvs {
                            var l = Agreement_Service(servicesRepo,agreementsRepo)
                            l.idService = Int(srv)
                            l.idAgreement = agr.id
                            sp_linksRepo.Add(&l)
                        }
                        print("READY")
                        return
                    }
                    
                }
            }
        }
    }
    print("ERROR")
}

initEntities()

while(true)
{
    print("Select option 1-all clients, 2-agreement by client id, 3-services by agreem id, 4-add agreement, 6-exit")
    if let o = readLine() {
        switch o {
            case "1":printClients()
            case "2":try AgrByClientId()
            case "3":try SrvByAgrId()
            case "4":try AddAgr()
            case "6":exit(0)
            default:print("ERROR")
        }
    } else {
        print("ERROR")
    }
}

