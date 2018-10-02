pragma solidity ^0.4.17;

contract RaiseFundsForACause {

  
    uint256  numPayments;
    
    uint256  totalAmountRaised;
    
    mapping(address => uint256) donationData;
    mapping (address => uint256) balanceOf;

    
    
    struct projectDet  {
        
        string projectTitle;
        string projectDescription;
        string user;
        uint256 dateOfPost;
        uint256 fundGoal;
        string  status;
        
    }
    
    mapping (uint => address) public projectToOwner;
    uint [] public projectIdList;
    projectDet[]  public projectDetails;
    event projAdded(uint id);
    event transferred(uint amount , address receiver );

  
    function addProject(string _title ,string _description ,string _user , uint256 _dateOfPost , uint256 _fundGoal) public {
        
        uint id = projectDetails.push(projectDet(_title, _description, _user, _dateOfPost, _fundGoal, "open" )) -1;
        projectIdList.push(id);
        projectToOwner[id] = msg.sender;
        
        emit projAdded(id);
    }

    function getCount() public view returns(uint) {
        return projectIdList.length;
    }
    
    function brosweproject(uint _id) public view returns(string , string , uint256 , uint256 , string , address) {
       return (projectDetails[_id].projectTitle , projectDetails[_id].projectDescription ,projectDetails[_id].dateOfPost , projectDetails[_id].fundGoal , projectDetails[_id].status , projectToOwner[_id]); 
  
    }
    
   
   function getAll(uint _id) public view returns(uint , string) {
         return (projectIdList[_id] , projectDetails[_id].projectTitle);
   }
    
    function getOpen(uint _id) public view returns(uint , string ) {
         
           if (uint256(keccak256(projectDetails[_id].status))  == uint256(keccak256("open"))) {
           return (projectIdList[_id] , projectDetails[_id].projectTitle);
           }
    
    }
    
    function getClosed(uint _id) public view returns(uint , string) {
        if (uint256(keccak256(projectDetails[_id].status))  == uint256(keccak256("closed"))) {
           return (projectIdList[_id] , projectDetails[_id].projectTitle);
           }
   }
   
   function setStatus(uint id) {
       
   }
    
    function transfer(address _receiever, uint256 _amount) public payable  {
       // require(balanceOf[msg.sender] >= _value);           // Check if the sender has enough
      //  balanceOf[msg.sender] -= _value;                    // Subtract from the sender
      //  balanceOf[_to] += _value;                           // Add the same to the recipient
      if(msg.sender.balance > _amount){
       _receiever.transfer(_amount);
     }
      emit transferred(_amount , _receiever );
    }

}