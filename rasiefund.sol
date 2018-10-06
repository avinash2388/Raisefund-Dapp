pragma solidity ^0.4.17;

contract RaiseFundsForACause {

  
    uint256  numPayments;
    
    uint256  totalAmountRaised;
    
    struct projectDet  {
        
        string projectTitle;
        string projectDescription;
        string user;
        uint256 dateOfPost;
        uint256 fundGoal;
        uint256 totalAmountRaised;
        string  status;
        
    }
    
    mapping (uint => address) public projectToOwner;
    mapping (address => mapping(uint => bool)) ifDonated;
    uint [] public projectIdList;
    projectDet[]  public projectDetails;
    event projAdded(uint id);
    event transferred(uint amount , uint id );

/* This function will add the entries of project */
    function addProject(string _title ,string _description ,string _user , uint256 _dateOfPost , uint256 _fundGoal) public {
        
        uint id = projectDetails.push(projectDet(_title, _description, _user, _dateOfPost, _fundGoal, 0,  "open" )) -1;
        projectIdList.push(id);
        projectToOwner[id] = msg.sender;
        
        emit projAdded(id);
    }
    
/* This will return the count of total projects entered */
    function getCount() public view returns(uint) {
        return projectIdList.length;
    }
    
/* This function will return the details of project for project id */
    function brosweproject(uint _id) public view returns(string , string , uint256 , uint256 , string , address , uint256) {
       return (projectDetails[_id].projectTitle , projectDetails[_id].projectDescription ,projectDetails[_id].dateOfPost , projectDetails[_id].fundGoal , projectDetails[_id].status , projectToOwner[_id] , projectDetails[_id].totalAmountRaised); 
  
    }

/* This function will return the list of all projects */    
   
   function getAll(uint _id) public view returns(uint , string) {
         return (projectIdList[_id] , projectDetails[_id].projectTitle);
   }

/* This function will return the list of all open projects */        
    function getOpen(uint _id) public view returns(uint , string ) {
         
           if (uint256(keccak256(projectDetails[_id].status))  == uint256(keccak256("open"))) {
           return (projectIdList[_id] , projectDetails[_id].projectTitle);
           }
    
    }


/* This function will return the list of all closed projects */        
    function getClosed(uint _id) public view returns(uint , string) {
        if (uint256(keccak256(projectDetails[_id].status))  == uint256(keccak256("closed"))) {
           return (projectIdList[_id] , projectDetails[_id].projectTitle);
           }
   }


/* This function will set the amount raised for any particular project */           
   function setAmountRaised(uint _id, uint256 _amount) public  {
       projectDetails[_id].totalAmountRaised += _amount;
       ifDonated[msg.sender][_id] = true;
       if (projectDetails[_id].totalAmountRaised >= projectDetails[_id].fundGoal)
       {
           setStatus(_id);
       }
       emit transferred(_amount , _id );
   }
   
   function getAmoutRaised(uint _id) public view returns(uint256){
       return(projectDetails[_id].totalAmountRaised);
   }
 
/* This function will return the status of project */          
   function getStatus(uint _id) public view returns(string , bool){
       return(projectDetails[_id].status , ifDonated[msg.sender][_id]);
   }
 

/* This function will be called and set the status to closed if fund goal reached */           
   function setStatus(uint _id) public {
       projectDetails[_id].status = 'closed';
   }
    

}
