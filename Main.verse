using {/Fortnite.com/Devices}
using {/Fortnite.com/Game}
using {/Verse.org/Simulation}
using {/UnrealEngine.com/Temporary/Diagnostics}
using {/Fortnite.com/Characters}
using {/UnrealEngine.com/Temporary/SpatialMath}
using { /Fortnite.com/Game }

MainDeviceController := class(creative_device):

    @editable AttachedProp : creative_prop = creative_prop{}
    # @editable TriggerProp : trigger_device = trigger_device{}
    # @editable Trigger : trigger_device = trigger_device{}
    @editable InvTrigger : trigger_device = trigger_device{}
    @editable AttackInput : input_trigger_device = input_trigger_device{}
    @editable PropTrigger : trigger_device = trigger_device{}
   
    GrabAgent(Agent : agent):void=
        spawn{AttachProp(Agent)}
    
    HandleGrabAgent(Agent : ?agent):void=
        if(ValidAgent := Agent?):
            GrabAgent(ValidAgent)
    
    BuyPowerInvisible(Agent:agent): void=
        if (InvisiblePlayer := Agent, FortCharacter := InvisiblePlayer.GetFortCharacter[]):
            FortCharacter.Hide()
            
            #retirar os comentarios abaixo para o personagem ficar invisivel por 10 segundos, depois voltar a ser visivel

           <# spawn:
                LostPowerInvisible(FortCharacter)

            LostPowerInvisible(FortCharacter : fort_character)<suspends> : void =
        Sleep(10.0)
        FortCharacter.Show() #>   

    AttachProp(Agent : agent)<suspends>:void=
        loop:
            if(FortCharacter := Agent.GetFortCharacter[]):
                Translation := FortCharacter.GetTransform().Translation
                BaseRotation := FortCharacter.GetTransform().Rotation

                NewRotation := BaseRotation.ApplyYaw(180.5)
                AttachedProp.MoveTo(Translation + vector3{Z:=-75.0}, NewRotation, 0.0001)
                Sleep(0.001)

    OnBegin<override>()<suspends>:void=
        PropTrigger.TriggeredEvent.Subscribe(HandleGrabAgent)
        InvTrigger.TriggeredEvent.Subscribe(HandleBuyPowerInvisible)
        AttackInput.PressedEvent.Subscribe(DoAttack)

    DoAttack(Agent : agent):void=
        if(FortCharacter := Agent.GetFortCharacter[]):

            MyTransform := FortCharacter.GetTransform()
            MyPos := MyTransform.Translation
            MyRot := MyTransform.Rotation

            Forward := MyRot.GetLocalForward()
            AttackCenter := MyPos + (Forward * 100.0)

            for (OtherAgent : GetPlayspace().GetPlayers()):
                if(OtherAgent <> Agent):
                    if(OtherChar := OtherAgent.GetFortCharacter[]):

                        OtherPos := OtherChar.GetTransform().Translation
                        Dist := Distance(MyPos, OtherPos)

                        if(Dist <= 180.0):
                            Print("GOT HIM")
                            OtherChar.Damage(200.0)
        
    <#DoAttack(Agent : agent):void=
        if(FortCharacter := Agent.GetFortCharacter[]):

            Transform := FortCharacter.GetTransform()
            Forward := Transform.Rotation.GetLocalForward()

            AttackPosition := Transform.Translation + (Forward * 100.0)

            for (OtherAgent : GetPlayspace().GetPlayers()):
                if(OtherAgent <> Agent):
                    if(OtherCharacter := OtherAgent.GetFortCharacter[]):

                        OtherPos := OtherCharacter.GetTransform().Translation
                        Dist := Distance(AttackPosition, OtherPos)

                        if(Dist < 100.0):
                            OtherCharacter.Damage(150.0)#>

    HandleBuyPowerInvisible(Agent : ?agent):void=
        if(ValidAgent := Agent?):
            BuyPowerInvisible(ValidAgent)
    
    
