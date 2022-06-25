//SPDX-License-Identifier: MIT
pragma solidity >0.7.0;

contract QTNK {
address private owner;
modifier onlyowner()
	{
		require(msg.sender == owner, "you are not the owner" );
    
		_;
	

  }
constructor()
	{
		owner=msg.sender;
	}
uint private tex;
uint public acount;
uint private basePrice;
uint private schoolShere;
uint public coursePrice;
mapping (address => bool) public allowToCourse;

function setCoursePrice (uint _tex, uint _basePrice, uint _schoolShere) internal onlyowner
{
    require(allowToCourse[msg.sender]== true,"you are not allowed");
    tex= _tex;
    basePrice= _basePrice;
    schoolShere= _schoolShere;
    coursePrice= tex+basePrice+schoolShere;     
}

function TeacherAllowed (address _addrl, bool _allow) public onlyowner 
    {
        allowToCourse[_addrl]=_allow;
    }
}

contract course is QTNK {
uint public c;

mapping (address => bool) public allow;
struct Course{
string name;
uint subjects;
uint timeEnd;
}
mapping (uint=>Course) private  coursdetails;

function addCourseDetails(uint courseID, string memory _name, uint _subjects,uint timeEnd) public onlyowner
{
require(allowToCourse[msg.sender]== true,"you are not allowed");
 c=courseID;
coursdetails[c]=Course(_name,_subjects,timeEnd);

}

function buyCourse() public payable{

  require (msg.value == coursePrice,"you send invalid amount please cheek course price");
  acount=acount+msg.value;
  allow[msg.sender]=true;
}

function getCousr(uint _cid) public view returns(string memory, uint)
    {
    require(allow[msg.sender] == true ,"plz First Purcase the course");
    return(coursdetails[_cid].name, coursdetails[_cid].subjects);
    }

function fundsTranfer(address payable _to, uint _amount) public onlyowner payable{

_to.transfer(_amount);
}
// work done by Mohsin
}
