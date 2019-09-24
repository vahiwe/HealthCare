pragma solidity ^0.5.0;


contract HealthCare {

    /* set owner */
    address owner;

    /* Add a line that creates a public mapping that maps an address to a Patient.
       Call this mappings patientDetails
    */
    mapping(address => Patient) patientDetails;

    /* Add a line that creates an enum called Gender. This should have 2 states
       Male
       Female
       (declaring them in this order is important for testing)
    */
    enum Gender {Male, Female}

    /* Add a line that creates an enum called Bloodgroup. This should have 4 states
       Bloodgroup: A
       Bloodgroup: B
       Bloodgroup: O
       Bloodgroup: AB
       (declaring them in this order is important for testing)
    */
    enum BloodGroup {A, B, O, AB}

    /** Create a struct named Patient.
    *   Here, add name, gender, Place of Birth, Bloodgroup and RegisterStatus
    */
    struct Patient {
        string name;
        uint gender;
        string POB;
        uint bloodgroup;
        bool registerStatus;
    }

    //
    // Modifiers
    //
    modifier isOwner{require(msg.sender == owner, "Message Sender should be the owner of the contract"); _;}
    modifier isRegistered(address _address){require(patientDetails[_address].registerStatus == true, "Require address to be registered"); _;}

    //
    // Functions
    //

    // Counstructor
    constructor() public {
        owner = msg.sender;
    }

    /// @notice Register customer
    //  Can only be called by owner of contract
    function addPatient(address _address, string memory _name, uint _gender, string memory _pob, uint _bg)
    public isOwner returns(bool){
        patientDetails[_address] = Patient({name: _name, gender: _gender, POB: _pob, bloodgroup: _bg, registerStatus: true});
        return true;
    }

    /// @notice Check registration Status of Customer
    /// @return _stat The registration status of the msg.sender
    function registrationStatus() public view returns (bool _stat) {
        return patientDetails[msg.sender].registerStatus;
    }

    /// @notice Get details of a Patient
    //  Can only be called by a Registered patient
    /// @return name, gender, Place of Birth of Patient
    function fetchPatientDetails() public view returns (string memory name, uint gender, string memory pob, uint bg) {
    name = patientDetails[msg.sender].name;
    gender = uint(patientDetails[msg.sender].gender);
    pob = patientDetails[msg.sender].POB;
    bg = uint(patientDetails[msg.sender].bloodgroup);
    return (name, gender, pob, bg);
  }
}