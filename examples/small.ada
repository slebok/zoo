--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
--

with Occupants;
use  Occupants;

package Creatures is
 type Creature is abstract new Occupant with private;
 type Creature_Access   is access Creature'Class;
private
 type Creature is abstract new Occupant with null record;
end Creatures;

--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright and authorship notice appear in all
-- copies and that both that copyright notice and this permission notice
-- appear in supporting documentation.
-- 
-- The ARA makes no representations about the suitability of this software
-- for any purpose.  It is provided "as is" without express
-- or implied warranty.
-- 
--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
--

with Ada.Characters.Handling;
use  Ada.Characters.Handling;

package body Directions is

 Abbreviations : constant String := "nsewud";

 procedure To_Direction(Text : in Unbounded_String;
                        Is_Direction : out Boolean;
                        Dir  : out Direction) is
  Lower_Text : String := To_Lower(To_String(Text));
  -- Attempt to turn "Text" into a direction.
  -- If successful, set "Is_Direction" True and "Dir" to the value.
  -- If not successful, set "Is_Direction" False and "Dir" to arbitrary value.
 begin
   if Length(Text) = 1 then
     -- Check if it's a one-letter abbreviation.
     for D in Direction'Range loop
       if Lower_Text(1) = Abbreviations(Direction'Pos(D) + 1) then
         Is_Direction := True;
         Dir := D;
         return;
       end if;
     end loop;
     Is_Direction := False;
     Dir := North;
     return;

   else
     -- Not a one-letter abbreviation, try a full name.
     for D in Direction'Range loop
       if Lower_Text = To_Lower(Direction'Image(D)) then
         Is_Direction := True;
         Dir := D;
         return;
       end if;
     end loop;
     Is_Direction := False;
     Dir := North;
     return;
   end if;
 end To_Direction;

 function To_Direction(Text : in Unbounded_String) return Direction is
   Is_Direction : Boolean;
   Dir          : Direction;
 begin
   To_Direction(Text, Is_Direction, Dir);
   if Is_Direction then
      return Dir;
   else
      raise Constraint_Error;
   end if;
 end To_Direction;

 function Is_Direction(Text : in Unbounded_String) return Boolean is
   Is_Direction : Boolean;
   Dir          : Direction;
 begin
   To_Direction(Text, Is_Direction, Dir);
   return Is_Direction;
 end Is_Direction;

end Directions;

--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright and authorship notice appear in all
-- copies and that both that copyright notice and this permission notice
-- appear in supporting documentation.
-- 
-- The ARA makes no representations about the suitability of this software
-- for any purpose.  It is provided "as is" without express
-- or implied warranty.
-- 
--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
--

with Ada.Strings.Unbounded;
use  Ada.Strings.Unbounded;

package Directions is

 type Direction is (North, South, East, West, Up, Down);

 Reverse_Direction : constant array(Direction) of Direction :=
                    (North => South, South => North,
                     East =>West, West => East,
                     Up => Down, Down => Up);

 function To_Direction(Text : Unbounded_String) return Direction;
 -- Converts Text to Direction; raises Constraint_Error if it's not
 -- a legal direction.

 function Is_Direction(Text : Unbounded_String) return Boolean;
 -- Returns TRUE if Text is a direction, else false.

end Directions;

--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright and authorship notice appear in all
-- copies and that both that copyright notice and this permission notice
-- appear in supporting documentation.
-- 
-- The ARA makes no representations about the suitability of this software
-- for any purpose.  It is provided "as is" without express
-- or implied warranty.
-- 
--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
--

package body Items is

 function May_I_Get(Direct_Object : access Item;
                    Agent : access Occupant'Class) return Boolean is
 begin
  return True;
 end May_I_Get;

end Items;

--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright and authorship notice appear in all
-- copies and that both that copyright notice and this permission notice
-- appear in supporting documentation.
-- 
-- The ARA makes no representations about the suitability of this software
-- for any purpose.  It is provided "as is" without express
-- or implied warranty.
-- 
--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
--

with Occupants;
use  Occupants;

package Items is
 type Item     is new Occupant with private;
 type Item_Access       is access Item'Class;
 function May_I_Get(Direct_Object : access Item;
                    Agent : access Occupant'Class) return Boolean;

private
 type Item     is new Occupant with null record;

end Items;

--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright and authorship notice appear in all
-- copies and that both that copyright notice and this permission notice
-- appear in supporting documentation.
-- 
-- The ARA makes no representations about the suitability of this software
-- for any purpose.  It is provided "as is" without express
-- or implied warranty.
-- 
--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
--

with Creatures;
use  Creatures;

package Monsters is
 type Monster is new Creature with private;
 type Monster_Access    is access Monster'Class;
private
 type Monster is new Creature with null record;
end Monsters;

--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright and authorship notice appear in all
-- copies and that both that copyright notice and this permission notice
-- appear in supporting documentation.
-- 
-- The ARA makes no representations about the suitability of this software
-- for any purpose.  It is provided "as is" without express
-- or implied warranty.
-- 
--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
--

with Text_IO, Ada.Strings.Unbounded, Ustrings, Rooms;
use  Text_IO, Ada.Strings.Unbounded, Ustrings, Rooms;

package body Occupants is


 procedure Put_View(T : access Occupant; Agent : access Thing'Class) is
 begin
  Put("You are inside ");
  Put_Line(Short_Description(T));
  Put_Line(".");
  Put_Contents(T, Agent, "You see:");
 end Put_View;

 procedure Look(T : access Occupant) is
 -- T is running a "look" command; tell T what he views.
 begin
  if Container(T) = null then
    Put("You are inside nothing at all.");
  else
    Put_View(Container(T), T);
  end if;
 end Look;


 procedure Get(Agent : access Occupant; Direct_Object : access Occupant'Class)
 is
 begin
   if May_I_Get(Direct_Object, Agent) then
     Place(T => Direct_Object, Into => Thing_Access(Agent));
   end if;
 end Get;
 
 function May_I_Get(Direct_Object : access Occupant;
                    Agent : access Occupant'Class)
          return Boolean is
 begin
   Sorry("get", Name(Direct_Object));  -- Tell the getter sorry, can't get it
   return False;
 end May_I_Get;
 
 procedure Drop(Agent : access Occupant;
                Direct_Object : access Occupant'Class) is
 begin
   if May_I_Drop(Direct_Object, Agent) then
     Place(T => Direct_Object, Into => Container(Agent));
   end if;
 end Drop;

 function  May_I_Drop(Direct_Object : access Occupant;
                      Agent : access Occupant'Class)
           return Boolean is
 begin
   return True;
 end May_I_Drop;
 

 procedure Inventory(Agent : access Occupant) is
 begin
  Put_Contents(Agent, Agent,
               "You're carrying:",
               "You aren't carrying anything.");
 end Inventory;

 procedure Go(Agent : access Occupant; Dir : in Direction) is
 begin
  if Container(Agent) = null then
    Put_Line("Sorry, you're not in a room!");
  else
    declare
      Destination : Thing_Access := What_Is(Container(Agent), Dir);
    begin
     if Destination = null then
       Put_Line("Sorry, you can't go that way.");
     else
       Place(Agent, Destination);
     end if;
    end;
  end if;
 end Go;
 
end Occupants;

--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright and authorship notice appear in all
-- copies and that both that copyright notice and this permission notice
-- appear in supporting documentation.
-- 
-- The ARA makes no representations about the suitability of this software
-- for any purpose.  It is provided "as is" without express
-- or implied warranty.
-- 
--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
--

with Things, Directions;
use  Things, Directions;

package Occupants is

 -- An "Occupant" is a Thing that can be inside a Room or another Occupant.

 type Occupant is abstract new Thing with private;
 type Occupant_Access   is access all Occupant'Class;

 -- Dispatching subprograms:

 procedure Look(T : access Occupant);      -- Ask Occupant T to "look".

 procedure Get(Agent : access Occupant; Direct_Object : access Occupant'Class);
           -- Ask Agent to get Direct_Object.  This assumes that Agent can
           -- somehow access Direct_Object (i.e. is in the same room).
           -- If the agent decides that it can get the object, it will
           -- call May_I_Get to ask the object if that's okay.

 procedure Drop(Agent : access Occupant; Direct_Object : access Occupant'Class);
           -- Ask Agent to drop Direct_Object.

 procedure Inventory(Agent : access Occupant);
           -- Ask Agent to print a list of what Agent is carrying.

 procedure Go(Agent : access Occupant; Dir : in Direction);
            -- Ask Agent to go the given Direction Dir (North, South, etc.)

 procedure Put_View(T : access Occupant; Agent : access Thing'Class);
            -- Override Thing's Put_View.
 
 function May_I_Get(Direct_Object : access Occupant;
                    Agent : access Occupant'Class) return Boolean;
           -- Ask Direct_Object if "Agent" can get this object.
           -- Returns True if it's okay, else False.
           -- If the object does something while being gotten (or an attempt
           -- to do so) it does it in this call.

 function  May_I_Drop(Direct_Object : access Occupant;
                      Agent         : access Occupant'Class) return Boolean;
           -- Ask Direct_Object if "Agent" can drop this object;
           -- returns True if it's okay.

private

 type Occupant is abstract new Thing with
  record
    null;  -- Nothing here for now.
  end record;

end Occupants;

--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright and authorship notice appear in all
-- copies and that both that copyright notice and this permission notice
-- appear in supporting documentation.
-- 
-- The ARA makes no representations about the suitability of this software
-- for any purpose.  It is provided "as is" without express
-- or implied warranty.
-- 
--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
--

with Text_IO, Ada.Strings.Maps.Constants, Ustrings, Things, Occupants, World;
use  Text_IO, Ada.Strings.Maps.Constants, Ustrings, Things, Occupants, World;
use  Ada.Strings, Ada.Strings.Maps;

with Directions;
use  Directions;

package body Parser is

 Spaces : constant Character_Set := To_Set(' ');

 procedure Split(Source     : in  Unbounded_String;
                 First_Word : out Unbounded_String;
                 Rest       : out Unbounded_String) is
  First : Positive; -- Index values of first word.
  Last  : Natural;
 -- Puts first word of Source into First_Word, the rest of the words in Rest
 -- (without leading spaces); words are separated by one or more spaces;
 -- if there are no spaces, Rest returns empty.
 begin
  Find_Token(Source, Spaces, Outside, First, Last);
  First_Word := U(Slice(Source, First, Last));
  Rest       := Trim(U(Slice(Source, Last + 1, Length(Source))), Left);
 end Split;



 procedure Execute(Command : in Unbounded_String; Quit : out Boolean) is
  Trimmed_Command : Unbounded_String := Trim(Command, Both);
  Verb, Arguments, First_Argument, Rest_Of_Arguments : Unbounded_String;
  Direct_Object : Occupant_Access;
 begin
  Quit := False; -- By default assume we won't quit.
  if (Empty(Trimmed_Command)) then
    return;      -- Ignore blank lines.
  end if;

  -- Extract Verb and First_Argument and force them to lower case.
  Split(Trimmed_Command, Verb, Arguments);
  Translate(Verb, Lower_Case_Map);
  Split(Arguments, First_Argument, Rest_Of_Arguments);
  Translate(First_Argument, Lower_Case_Map);


  -- Try to execute "Verb".

  if    Verb = "look" then
    Look(Me);
  elsif Verb = "get" then
    Direct_Object := Occupant_Access(Find(Me, First_Argument));
    if Direct_Object /= null then
      Get(Me, Direct_Object);
    end if;
  elsif Verb = "drop" then
    Direct_Object := Occupant_Access(Find_Inside(Me, First_Argument));
    if Direct_Object /= null then
      Drop(Me, Direct_Object);
    end if;
  elsif Verb = "inventory" or Verb = "inv" then
    Inventory(Me);
  elsif Verb = "quit" then
    Quit := True;
  elsif Verb = "go" and then Is_Direction(First_Argument) then
    Go(Me, To_Direction(First_Argument));
    Look(Me);
  elsif Is_Direction(Verb) then  -- Is the verb a direction (north, etc)?
    Go(Me, To_Direction(Verb));
    Look(Me);
  elsif Verb = "help" then
    Put_Line("Please type in one or two word commands, beginning with a verb");
    Put_Line("or direction. Directions are north, south, east, west, etc.");
    Put_Line("Here are some sample commands:");
    Put_Line("look, get box, drop box, inventory, go west, west, w, quit.");
  else
   Put_Line("Sorry, I don't recognize that verb. Try 'help'.");
  end if;
  
 end Execute;
end Parser;

--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright and authorship notice appear in all
-- copies and that both that copyright notice and this permission notice
-- appear in supporting documentation.
-- 
-- The ARA makes no representations about the suitability of this software
-- for any purpose.  It is provided "as is" without express
-- or implied warranty.
-- 
--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
--
 
with Ada.Strings.Unbounded;
use  Ada.Strings.Unbounded;

package Parser is
 procedure Execute(Command : in Unbounded_String; Quit : out Boolean);
   -- Executes the given command.
   -- Sets Quit to False if the user may run additional commands.
end Parser;

--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright and authorship notice appear in all
-- copies and that both that copyright notice and this permission notice
-- appear in supporting documentation.
-- 
-- The ARA makes no representations about the suitability of this software
-- for any purpose.  It is provided "as is" without express
-- or implied warranty.
-- 
--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
--

with Creatures;
use  Creatures;

package Players is
 type Player  is new Creature with private;
 type Player_Access     is access Player'Class;
private
 type Player  is new Creature with null record;
end Players;

--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright and authorship notice appear in all
-- copies and that both that copyright notice and this permission notice
-- appear in supporting documentation.
-- 
-- The ARA makes no representations about the suitability of this software
-- for any purpose.  It is provided "as is" without express
-- or implied warranty.
-- 
--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
--

with Text_IO, Ustrings;
use  Text_IO, Ustrings;

package body Rooms is

 procedure Connect(Source : access Room; Dir : in Direction; 
                   Destination : access Thing'Class;
                   Bidirectional : in Boolean := True) is
 begin
   Source.Destinations(Dir) := Thing_Access(Destination);
   if Bidirectional then  -- Connect in reverse direction.
     Room_Access(Destination).Destinations(Reverse_Direction(Dir)) := 
              Thing_Access(Source);
   end if;
 end Connect;

 procedure Disconnect(Source : access Room; Dir : in Direction; 
                      Bidirectional : in Boolean := True) is
 begin
   if Bidirectional then
     -- If it's bidirectional, remove the other direction. The following "if"
     -- statement, if uncommented, checks to make sure that
     -- disconnecting a bidirectional link only happens to a Room.
     -- if (Source.Destinations(Dir).all'Tag in Room'Class) then
       Room_Access(Source.Destinations(Dir)).
                   Destinations(Reverse_Direction(Dir)) := null;
     -- end if;
   end if;
   Source.Destinations(Dir) := null;
 end Disconnect;

 function What_Is(From : access Room; Dir : in Direction) return Thing_Access is
 begin
  return From.Destinations(Dir);
 end What_Is;

 procedure Put_View(T : access Room; Agent : access Thing'Class) is
 begin
  Put("You are ");
  Put(Long_Description(T));
  Put_Line(".");
  Put_Contents(T, Agent, "You see:");
 end Put_View;

end Rooms;

--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright and authorship notice appear in all
-- copies and that both that copyright notice and this permission notice
-- appear in supporting documentation.
-- 
-- The ARA makes no representations about the suitability of this software
-- for any purpose.  It is provided "as is" without express
-- or implied warranty.
-- 
--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
--

with Things, Directions;
use  Things, Directions;

package Rooms is
 type Room     is new Thing with private;
 type Room_Access       is access all Room'Class;

 procedure Put_View(T : access Room; Agent : access Thing'Class);

 procedure Connect(Source : access Room; Dir : in Direction; 
                   Destination : access Thing'Class;
                   Bidirectional : in Boolean := True);
  -- Create a connection from Source to Destination in Direction Dir.
  -- If it's bidirectional, create another connection the reverse way.

 procedure Disconnect(Source : access Room; Dir : in Direction; 
                      Bidirectional : in Boolean := True);
 -- Reverse of connect; disconnects an existing connection, if any.

 function What_Is(From : access Room; Dir : in Direction) return Thing_Access;
 -- Returns what is at direction "Dir" from "From".
 -- Returns null if nothing connected in that direction.

private

 type Destination_Array is array(Direction) of Thing_Access;

 type Room     is new Thing with
  record
    Destinations : Destination_Array;
  end record;

end Rooms;

--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright and authorship notice appear in all
-- copies and that both that copyright notice and this permission notice
-- appear in supporting documentation.
-- 
-- The ARA makes no representations about the suitability of this software
-- for any purpose.  It is provided "as is" without express
-- or implied warranty.
-- 

-- Main routine to start up "Small", a small text adventure game to
-- demonstrate Ada 95.

--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
--

-- For documentation see the following URL:
--   http://www.adahome.com//Tutorials/Lovelace/small.htm

with Text_IO, Ada.Strings.Unbounded, Ustrings, World;
use  Text_IO, Ada.Strings.Unbounded, Ustrings;

with Parser;

procedure Small is
  Command : Unbounded_String; -- Contains user's current command.
  Quit    : Boolean := False;
begin
 Put_Line("Welcome to a Small World!");

 World.Setup;

 while not Quit loop
  New_Line;
  Put_Line("Your Command?");
  Get_Line(Command);
  Parser.Execute(Command, Quit);
 end loop;

 Put_Line("Bye!");
end Small;

--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright and authorship notice appear in all
-- copies and that both that copyright notice and this permission notice
-- appear in supporting documentation.
-- 
-- The ARA makes no representations about the suitability of this software
-- for any purpose.  It is provided "as is" without express
-- or implied warranty.
-- 
--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
--

with Text_IO, Ustrings;
use  Text_IO, Ustrings;


package body Things is

 -- Define basic types for the world and their operations.


 -- Supporting Subprograms:

 procedure Sorry(Prohibited_Operation : String;
                 Prohibited_Direct_Object : Unbounded_String) is
 begin
  Put_Line("Sorry, you may not " & Prohibited_Operation & " the " &
           S(Prohibited_Direct_Object));
 end Sorry;


 -- Routines to manipulate First_Containee, Next_Sibling, Container:

 function Previous_Sibling(Containee : access Thing'Class)
          return Thing_Access is
  -- Find the previous sibling of containee.  It's an error to call
  -- this if Containee has no previous sibling.
    Current : Thing_Access := Containee.Container.First_Containee;
 begin
    while Current.Next_Sibling /= Thing_Access(Containee) loop
      Current := Current.Next_Sibling;
    end loop;
    return Current;
 end Previous_Sibling;

 function Last_Containee(Container : access Thing'Class)
          return Thing_Access is
   -- Return an access value of the last contained Thing in container.
   -- It's an error to call this routine if there are no containees.
    Current : Thing_Access := Container.First_Containee;
 begin
    while Current.Next_Sibling /= null loop
      Current := Current.Next_Sibling;
    end loop;
    return Current;
 end Last_Containee;

 procedure Remove(Containee : access Thing'Class) is
 -- Remove Containee from its current Container.
  Previous_Thing : Thing_Access;
 begin
  if Containee.Container /= null then
    if Containee.Container.First_Containee = Thing_Access(Containee) then
       -- Containee is the first Thing in its container.
       Containee.Container.First_Containee := Containee.Next_Sibling;
    else
       Previous_Thing := Previous_Sibling(Containee);
       Previous_Thing.Next_Sibling := Containee.Next_Sibling;
    end if;
    Containee.Next_Sibling := null;
    Containee.Container    := null;
  end if;
 end Remove;


 procedure Place(T : access Thing'Class; Into : Thing_Access) is
 -- Place "T" inside "Into".
  Last : Thing_Access;
 begin
  if (Thing_Access(T) = Into) then
    Put_Line("Sorry, that can't be done.");
    return;
  end if;
  Remove(T); -- Remove Thing from where it is now.
  if Into /= null then
    if Into.First_Containee = null then
      Into.First_Containee := Thing_Access(T);
    else
      Last := Last_Containee(Into);
      Last.all.Next_Sibling := Thing_Access(T);
    end if;
  end if;
  T.Container := Into;
 end Place;

 procedure Put_Contents(T : access Thing'Class;
                        Ignore : access Thing'Class;
                        Heading_With_Contents : in String;
                        Heading_Without_Contents : in String := "") is
   -- Put a description of the contents of T.
   -- If there is something, print Heading_With_Contents;
   -- If there isn't something, print Heading_Without_Contents.
   -- Ignore The_Player, since presumably the player already knows about
   -- him/herself.
   Current : Thing_Access := T.First_Containee;
   Have_Put_Something : Boolean := False;
 begin
  while Current /= null loop
    if Current /= Thing_Access(Ignore) then
      -- This what we're to ignore, print it out.
      if Have_Put_Something then
        Put(", ");
      else
        -- We're about to print the first item; print the heading.
        Put_Line(Heading_With_Contents);
      end if;
      Put(Short_Description(Current));
      Have_Put_Something := True;
    end if;
    Current := Current.Next_Sibling;
  end loop;
  if Have_Put_Something then
    Put_Line(".");
  elsif Heading_With_Contents'Length > 0 then
    Put_Line(Heading_Without_Contents);
  end if;
 end Put_Contents;


 -- Dispatching Operations:

 function What_Is(From : access Thing; Dir : in Direction)
          return Thing_Access is
 begin
   return null; -- As a default, you can't go ANY direction from "here".
 end What_Is;


 -- Non-dispatching public operations:

 procedure Set_Name(T : access Thing'Class; Article : in Article_Type;
                    Name : in Unbounded_String) is
 begin
   T.Article := Article;
   T.Name    := Name;
 end Set_Name;

 procedure Set_Name(T : access Thing'Class; Article : in Article_Type;
                    Name : in String) is
 begin
   T.Article := Article;
   T.Name    := To_Unbounded_String(Name);
 end Set_Name;

 function Name(T : access Thing'Class) return Unbounded_String is
 begin
  return T.Name;
 end Name;

 procedure Set_Description(T : access Thing'Class;
                           Description : in Unbounded_String) is
 begin
  T.Description := Description;
 end Set_Description;

 procedure Set_Description(T : access Thing'Class;
                           Description : in String) is
 begin
  T.Description := To_Unbounded_String(Description);
 end Set_Description;

 function Long_Description(T : access Thing'Class) return Unbounded_String is
 begin
   return T.Description;
 end Long_Description;
 

 -- Eventually we'll use an array for the article, but a minor GNAT 2.7.0 bug
 -- will cause this to raise a Segmentation Fault when the program quits:
 -- Article_Text : constant array(Article_Type) of Unbounded_String :=
 --     (A => U("a "), An => U("an "), The => U("the "), Some => U("some "),
 --      None => U(""));

 function Short_Description(T : access Thing'Class) return Unbounded_String is
 begin
  case T.Article is
   when A    => return "a "    & T.Name;
   when An   => return "an "   & T.Name;
   when The  => return "the "  & T.Name;
   when Some => return "some " & T.Name;
   when None => return           T.Name;
  end case;
  -- Should become return Article_Text(T.Article) & T.Name;
 end Short_Description;

 function Find(Agent : access Thing'Class;
               Object_Name : in Unbounded_String) return Thing_Access is
 begin
   if Agent.Container = null then
     Put_Line("You aren't in anything.");
     return null;
   else
     return Find_Inside(Agent.Container, Object_Name);
   end if;
 end Find;

 function Find_Inside(Agent : access Thing'Class;
                      Object_Name : in Unbounded_String)
          return Thing_Access is
   Current : Thing_Access := Agent.First_Containee;
 begin
   if Empty(Object_Name) then
     Put_Line("Sorry, you need to name an object.");
     return null;
   end if;
   while Current /= null loop
     if Current.Name = Object_Name then
       return Current;
     end if;
     Current := Current.Next_Sibling;
   end loop;
   Put("Sorry, I don't see a ");
   Put_Line(Object_Name);
   return null;
 end Find_Inside;

 function Container(T : access Thing'Class) return Thing_Access is
 begin
   return T.Container;
 end Container;

 function Has_Contents(T : access Thing'Class) return Boolean is
 begin
   if T.First_Containee = null then
     return False;
   else
     return True;
   end if;
 end Has_Contents;

end Things;

--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright and authorship notice appear in all
-- copies and that both that copyright notice and this permission notice
-- appear in supporting documentation.
-- 
-- The ARA makes no representations about the suitability of this software
-- for any purpose.  It is provided "as is" without express
-- or implied warranty.
-- 
--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
--

with Ada.Strings.Unbounded, Ada.Finalization, Directions;
use  Ada.Strings.Unbounded, Ada.Finalization, Directions;

package Things is

 -- "Thing" is the root class for all things in this small world.
 -- Rooms, Players, Items, and Monsters are derived from Thing.

 
 type Thing is abstract new Limited_Controlled with private;
 type Thing_Access is access all Thing'Class;

 type Article_Type is (A, An, The, Some, None);

 -- Public Dispatching operations.

 procedure Put_View(T : access Thing; Agent : access Thing'Class) is abstract;
  -- Put what Agents sees inside T.

 function What_Is(From : access Thing; Dir : in Direction) return Thing_Access;
 -- Returns what is at direction "Dir" from "From".
 -- Returns null if nothing connected in that direction.

 -- Public non-Dispatching operations:

 procedure Set_Name(T : access Thing'Class; Article : in Article_Type;
                    Name : in Unbounded_String);
 procedure Set_Name(T : access Thing'Class; Article : in Article_Type;
                    Name : in String);
 function Name(T : access Thing'Class) return Unbounded_String;
 pragma Inline(Name);

 function Short_Description(T : access Thing'Class) return Unbounded_String;
 -- Returns Article + Name, i.e. "the box", "a car", "some horses".
 
 procedure Set_Description(T : access Thing'Class;
                           Description : in Unbounded_String);
 procedure Set_Description(T : access Thing'Class;
                           Description : in String);
 function Long_Description(T : access Thing'Class) return Unbounded_String;
 
 procedure Place(T : access Thing'Class; Into : Thing_Access);
   -- Place T inside "Into" (removing it from wherever it was).
   -- Attempting to place T into itself will print an error message
   -- and fail.
   -- The second parameter is Thing_Access, not Thing'Class, because
   -- "null" is a valid value for "Into".
 function Container(T : access Thing'Class) return Thing_Access;
   -- Return access value to the container of T.
 function Has_Contents(T : access Thing'Class) return Boolean;
   -- Does T have anything in it?

 function Find(Agent : access Thing'Class;
               Object_Name : in Unbounded_String) return Thing_Access;
          -- Find the given Object_Name in the same container as the agent.
          -- Prints and error message and returns null if not found.

 function Find_Inside(Agent       : access Thing'Class;
                      Object_Name : in Unbounded_String)
          return Thing_Access;
          -- Find the given Object_Name inside the agent.
          -- Prints and error message and returns null if not found.

 procedure Put_Contents(T : access Thing'Class;
                        Ignore : access Thing'Class;
                        Heading_With_Contents : in String;
                        Heading_Without_Contents : in String := "");
   -- Put a description of the contents of T.
   -- Act as though "Ignore" isn't there.
   -- If there is something, print Heading_With_Contents;
   -- If there isn't something, print Heading_Without_Contents.

 procedure Sorry(Prohibited_Operation : String;
                 Prohibited_Direct_Object : Unbounded_String);
   -- Put "Sorry, you may not XXX the YYY".


private

 type Thing is abstract new Limited_Controlled with
  record
   Name, Description : Unbounded_String;
   Article           : Article_Type := A;
   Container         : Thing_Access; -- what Thing contains me?
   Next_Sibling      : Thing_Access; -- next Thing in my container.
   First_Containee   : Thing_Access; -- first Thing inside me.
  end record;

end Things;

--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright and authorship notice appear in all
-- copies and that both that copyright notice and this permission notice
-- appear in supporting documentation.
-- 
-- The ARA makes no representations about the suitability of this software
-- for any purpose.  It is provided "as is" without express
-- or implied warranty.
-- 
--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
--

package body Ustrings is

  Input_Line_Buffer_Length : constant := 1024;
    -- If an input line is longer, Get_Line will recurse to read in the line.


  procedure Swap(Left, Right : in out Unbounded_String) is
    -- Implement Swap.  This is the portable but slow approach.
    Temporary : Unbounded_String;
  begin
    Temporary := Left;
    Left := Right;
    Right := Temporary;
  end Swap;

  function Empty(S : Unbounded_String) return Boolean is
   -- returns True if Length(S)=0.
  begin
   return (Length(S) = 0);
  end Empty;
 

  -- Implement Unbounded_String I/O by calling Text_IO String routines.


  -- Get_Line gets a line of text, limited only by the maximum number of
  -- characters in an Unbounded_String.  It reads characters into a buffer
  -- and if that isn't enough, recurses to read the rest.

  procedure Get_Line (File : in File_Type; Item : out Unbounded_String) is

    function More_Input return Unbounded_String is
       Input : String (1 .. Input_Line_Buffer_Length);
       Last  : Natural;
    begin
       Get_Line (File, Input, Last);
       if Last < Input'Last then
          return   To_Unbounded_String (Input(1..Last));
       else
          return   To_Unbounded_String (Input(1..Last)) & More_Input;
       end if;
    end More_Input;

  begin
      Item := More_Input;
  end Get_Line;


  procedure Get_Line(Item : out Unbounded_String) is
  begin
    Get_Line(Current_Input, Item);
  end Get_Line;

  procedure Put(File : in File_Type; Item : in Unbounded_String) is
  begin
    Put(File, To_String(Item));
  end Put;

  procedure Put(Item : in Unbounded_String) is
  begin
    Put(Current_Output, To_String(Item));
  end Put;

  procedure Put_Line(File : in File_Type; Item : in Unbounded_String) is
  begin
    Put(File, Item);
    New_Line(File);
  end Put_Line;

  procedure Put_Line(Item : in Unbounded_String) is
  begin
    Put(Current_Output, Item);
    New_Line;
  end Put_Line;

end Ustrings;

--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright and authorship notice appear in all
-- copies and that both that copyright notice and this permission notice
-- appear in supporting documentation.
-- 
-- The ARA makes no representations about the suitability of this software
-- for any purpose.  It is provided "as is" without express
-- or implied warranty.
-- 
--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
--

with Text_IO, Ada.Strings.Unbounded;
use  Text_IO, Ada.Strings.Unbounded;

package Ustrings is

  -- This package provides a simpler way to work with type
  -- Unbounded_String, since this type will be used very often.
  -- Most users will want to ALSO with "Ada.Strings.Unbounded".
  -- Ideally this would be a child package of "Ada.Strings.Unbounded".
  --

  -- This package provides the following simplifications:
  --  + Shortens the type name from "Unbounded_String" to "Ustring".
  --  + Creates shorter function names for To_Unbounded_String, i.e.
  --    To_Ustring(U) and U(S).  "U" is not a very readable name, but
  --    it's such a common operation that a short name seems appropriate
  --    (this function is needed every time a String constant is used).
  --    It also creates S(U) as the reverse of U(S).
  --  + Adds other subprograms, currently just "Swap".
  --  + Other packages can use this package to provide other simplifications.

  subtype Ustring is Unbounded_String;

  function To_Ustring(Source : String)  return Unbounded_String
                                         renames To_Unbounded_String;
  function U(Source : String)           return Unbounded_String
                                         renames To_Unbounded_String;
  function S(Source : Unbounded_String) return String
                                         renames To_String;

  -- "Swap" is important for reuse in some other packages, so we'll define it.

  procedure Swap(Left, Right : in out Unbounded_String);


  function Empty(S : Unbounded_String) return Boolean;
   -- returns True if Length(S)=0.
  pragma Inline(Empty);


  -- I/O Routines.
  procedure Get_Line(File : in File_Type; Item : out Unbounded_String);
  procedure Get_Line(Item : out Unbounded_String);

  procedure Put(File : in File_Type; Item : in Unbounded_String);
  procedure Put(Item : in Unbounded_String);

  procedure Put_Line(File : in File_Type; Item : in Unbounded_String);
  procedure Put_Line(Item : in Unbounded_String);

end Ustrings;

--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright and authorship notice appear in all
-- copies and that both that copyright notice and this permission notice
-- appear in supporting documentation.
-- 
-- The ARA makes no representations about the suitability of this software
-- for any purpose.  It is provided "as is" without express
-- or implied warranty.
-- 
--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
--

with Text_IO, Ada.Strings.Unbounded, Ustrings;
use  Text_IO, Ada.Strings.Unbounded, Ustrings;

with Things, Players, Items, Rooms, Directions;
use  Things, Players, Items, Rooms, Directions;

package body World is

 The_Player : Player_Access;    -- This is the object representing the
                                -- current player.


 procedure Setup is
   Starting_Room : Room_Access := new Room;
   Box           : Item_Access := new Item;
   Knife         : Item_Access := new Item;
   Living_Room   : Room_Access := new Room;
 begin
   Set_Name(Starting_Room, The, "Hallway");
   Set_Description(Starting_Room, "in the hallway. There is a living room " &
                   "to the west");

   Set_Name(Box, A, "box");
   Set_Description(Box, "a red box");
   Place(T => Box, Into => Thing_Access(Starting_Room));

   Set_Name(Knife, A, "knife");
   Set_Description(Box, "a black knife");
   Place(T => Knife, Into => Thing_Access(Starting_Room));

   Set_Name(Living_Room, The, "Living Room");
   Set_Description(Living_Room, "in the living room. " &
                                "A hallway is to your east");
   Connect(Starting_Room, West, Living_Room);

   -- Setup player.
   The_Player := new Player; 
   Set_Name(The_Player, None, "Fred");
   Set_Description(The_Player, Name(The_Player));
   Place(T => Me,  Into => Thing_Access(Starting_Room));
   Look(Me);

 end Setup;


 function Me return Occupant_Access is
  -- Return access value to current player.
 begin
  return Occupant_Access(The_Player);
 end Me;

end World;

--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright and authorship notice appear in all
-- copies and that both that copyright notice and this permission notice
-- appear in supporting documentation.
-- 
-- The ARA makes no representations about the suitability of this software
-- for any purpose.  It is provided "as is" without express
-- or implied warranty.
-- 
--
-- Copyright (C) 1996 Ada Resource Association (ARA), Columbus, Ohio.
-- Author: David A. Wheeler
--

with Occupants;
use  Occupants;

package World is

 procedure Setup;
  -- Setup the World; initialize the contents of the world.


 function Me return Occupant_Access;
           -- Return an access variable pointing to the current player.

end World;

--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright and authorship notice appear in all
-- copies and that both that copyright notice and this permission notice
-- appear in supporting documentation.
-- 
-- The ARA makes no representations about the suitability of this software
-- for any purpose.  It is provided "as is" without express
-- or implied warranty.
-- 